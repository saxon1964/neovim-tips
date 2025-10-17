#!python3

import os
from typing import List


class LatexUtil:
  @staticmethod
  def getLatex(text: str) -> str:
    """Escapes LaTeX special characters outside of code blocks."""
    latex_special_chars = {
      '\\': r'\textbackslash{}',
      '{': r'\{',
      '}': r'\}',
      '$': r'\$',
      '&': r'\&',
      '%': r'\%',
      '#': r'\#',
      '_': r'\_',
      '~': r'\textasciitilde{}',
      '^': r'\textasciicircum{}'
    }

    result = []
    i = 0
    while i < len(text):
      # Check for multi-line code block
      if text[i:i+3] == '```':
        # Find the end of the first line (after ```)
        first_line_end = text.find('\n', i)
        if first_line_end == -1:
          first_line_end = i + 3

        # Find the closing ```
        end = text.find('```', i + 3)
        if end != -1:
          # Extract the code content (between first newline and closing ```)
          code_start = first_line_end + 1 if first_line_end > i + 3 else i + 3
          code_content = text[code_start:end].rstrip('\n')

          # Replace with LaTeX verbatim environment (using Verbatim from fvextra)
          result.append(r'\begin{Exa*}{}' + '\n')
          result.append(r'\begin{Verbatim}[fontsize=\footnotesize, breaklines, breakanywhere]' + '\n')
          result.append(code_content + '\n')
          result.append(r'\end{Verbatim}' + '\n')
          result.append(r'\end{Exa*}')

          i = end + 3
          continue

      # Check for inline code block - handle double backticks first
      if text[i:i+2] == '``':
        # Look for closing double backticks
        end = text.find('``', i + 2)
        if end != -1:
          code_content = text[i+2:end].strip()  # Strip spaces for double backticks
          result.append(r'{\footnotesize \Verb§' + code_content + '§}')
          i = end + 2
          continue

      # Check for single backtick inline code
      if text[i] == '`':
        end = text.find('`', i + 1)
        if end != -1:
          code_content = text[i+1:end]
          result.append(r'{\footnotesize \Verb§' + code_content + '§}')
          i = end + 1
          continue

      # Escape special LaTeX characters
      if text[i] in latex_special_chars:
        result.append(latex_special_chars[text[i]])
      else:
        result.append(text[i])

      i += 1

    return ''.join(result)

  @staticmethod
  def getLatexForTitle(text: str) -> str:
    """Escapes LaTeX for use in section/chapter titles (cannot use \\verb)."""
    latex_special_chars = {
      '\\': r'\textbackslash{}',
      '{': r'\{',
      '}': r'\}',
      '$': r'\$',
      '&': r'\&',
      '%': r'\%',
      '#': r'\#',
      '_': r'\_',
      '~': r'\textasciitilde{}',
      '^': r'\textasciicircum{}'
    }

    result = []
    i = 0
    while i < len(text):
      # Check for inline code block - handle double backticks first
      if text[i:i+2] == '``':
        end = text.find('``', i + 2)
        if end != -1:
          code_content = text[i+2:end].strip()
          # Escape special chars in code content
          escaped_code = code_content
          for char, replacement in latex_special_chars.items():
            escaped_code = escaped_code.replace(char, replacement)
          result.append(r'\texttt{' + escaped_code + '}')
          i = end + 2
          continue

      # Check for single backtick inline code
      if text[i] == '`':
        end = text.find('`', i + 1)
        if end != -1:
          code_content = text[i+1:end]
          # Escape special chars in code content
          escaped_code = code_content
          for char, replacement in latex_special_chars.items():
            escaped_code = escaped_code.replace(char, replacement)
          result.append(r'\texttt{' + escaped_code + '}')
          i = end + 1
          continue

      # Escape special LaTeX characters
      if text[i] in latex_special_chars:
        result.append(latex_special_chars[text[i]])
      else:
        result.append(text[i])

      i += 1

    return ''.join(result)


class Tip:
  def __init__(self, content: str) -> None:
    self.content = content

  def get_title(self) -> str:
    """Returns the text after 'Title:' trimmed."""
    for line in self.content.split('\n'):
      if line.startswith('# Title:'):
        return line.split(':', 1)[1].strip()
    return ''

  def get_category(self) -> str:
    """Returns the text after 'Category:' trimmed."""
    for line in self.content.split('\n'):
      if line.startswith('# Category:'):
        return line.split(':', 1)[1].strip()
    return ''

  def get_tags(self) -> str:
    """Returns the text after 'Tags:' trimmed."""
    for line in self.content.split('\n'):
      if line.startswith('# Tags:'):
        return line.split(':', 1)[1].strip()
    return ''

  def get_body(self) -> str:
    """Returns the tip text after the '---' separator."""
    if '---' not in self.content:
      return ''

    body = self.content.split('---', 1)[1].strip()
    return body

  def get_title_latex(self) -> str:
    """Returns LaTeX-escaped title (safe for use in \\section)."""
    return LatexUtil.getLatexForTitle(self.get_title())

  def get_category_latex(self) -> str:
    """Returns LaTeX-escaped category."""
    return LatexUtil.getLatex(self.get_category())

  def get_tags_latex(self) -> str:
    """Returns LaTeX-escaped tags."""
    return LatexUtil.getLatex(self.get_tags())

  def get_body_latex(self) -> str:
    """Returns LaTeX-escaped body."""
    return LatexUtil.getLatex(self.get_body())

  def toLatex(self) -> str:
    """Returns the tip formatted as LaTeX using the template."""
    template = r"""\section{%s}

\textbf{Category}: %s\\ \textbf{Tags}: %s
\vspace{0.5cm}

%s

"""
    return template % (
      self.get_title_latex(),
      self.get_category_latex(),
      self.get_tags_latex(),
      self.get_body_latex()
    )


class FileList:
  def __init__(self, directory_path: str) -> None:
    self.directory_path = directory_path

  def get_files_by_extension(self, extension: str) -> List[str]:
    """Returns a list of files with the given extension in alphabetical order."""
    if not os.path.exists(self.directory_path):
      return []

    files = []
    for filename in os.listdir(self.directory_path):
      file_path = os.path.join(self.directory_path, filename)
      if os.path.isfile(file_path) and filename.endswith(extension):
        files.append(os.path.abspath(file_path))

    return sorted(files)


class TipsParser:
  def __init__(self, file_path: str) -> None:
    self.file_path = file_path

  def get_title(self) -> str:
    """Returns title based on filename: capitalize first letter and replace underscores with spaces."""
    filename = os.path.basename(self.file_path)
    name_without_ext = os.path.splitext(filename)[0]
    title = name_without_ext.replace('_', ' ')
    return title.capitalize()

  def get_tips(self) -> List[Tip]:
    """Returns a list of Tip objects parsed from the file."""
    if not os.path.exists(self.file_path):
      return []

    with open(self.file_path, 'r') as f:
      content = f.read()

    tips = []
    sections = content.split('***')

    for section in sections:
      section = section.strip()
      if section:
        tips.append(Tip(section))

    return sorted(tips, key=lambda tip: tip.get_title())

  def toLatex(self) -> str:
    """Returns LaTeX formatted output starting with chapter title."""
    result = r'\chapter{%s}' % LatexUtil.getLatexForTitle(self.get_title()) + '\n'
    for tip in self.get_tips():
      result += tip.toLatex()
    return result


class BookWriter:
  def __init__(self, source_directory: str, source_extension: str, output_tex_file: str) -> None:
    self.source_directory = source_directory
    self.source_extension = source_extension
    self.output_tex_file = output_tex_file

  def write(self) -> None:
    """Writes LaTeX output from all source files to the output file."""
    # Validate source directory exists
    if not os.path.exists(self.source_directory):
      raise ValueError(f"Source directory does not exist: {self.source_directory}")

    if not os.path.isdir(self.source_directory):
      raise ValueError(f"Source path is not a directory: {self.source_directory}")

    # Validate output directory exists
    output_dir = os.path.dirname(self.output_tex_file)
    if output_dir and not os.path.exists(output_dir):
      raise ValueError(f"Output directory does not exist: {output_dir}")

    # Get list of source files
    file_lister = FileList(self.source_directory)
    source_files = file_lister.get_files_by_extension(self.source_extension)

    if not source_files:
      raise ValueError(f"No files found with extension '{self.source_extension}' in {self.source_directory}")

    # Open output file for writing
    try:
      with open(self.output_tex_file, 'w') as output:
        # Process each source file
        for source_file in source_files:
          parser = TipsParser(source_file)
          latex_content = parser.toLatex()
          output.write(latex_content)
    except IOError as e:
      raise IOError(f"Failed to write to output file {self.output_tex_file}: {e}")


if __name__ == "__main__":
  # Example usage: Convert markdown tips to LaTeX book
  writer = BookWriter("../data", ".md", "Tmp/Content.tex")
  writer.write()
  print("Book created")
