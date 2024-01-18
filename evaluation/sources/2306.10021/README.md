# Software Ecosystems: Tooling and Analytics

LaTeX sources for the collaborative Springer book on "Software Ecosystems: Tooling and Analytics"

## Timeline
- *1 October 2022*: Submission of stable version of each chapter by chapter authors, for review
- October-November 2022: Review period (by all authors and editors) of the submitted version of each chapter
- *Friday, 2 December 2022*: End of reviewing period. All chapters need to have received at least three reviews.
- *Friday, 3 February 2023*: Revision due for revised chapters, taking into account the received reviews
- February-March 2023: Revision by the book editors (with the help of chapter authors whenever requested) to make everything consistent and coherent, take care of foreword and other sections of the book (index, glossary, acronyms, cross-referencing, introduction chapter,...)
- April-May 2023: Final reviewing and streamlining
- June 2023: Send everything to publisher for copy-editing

## Repository structure and instructions to chapter authors 

The fully compiled version of the book can be found in book.pdf at the root of the main branch of this repository. This pdf can be generated directly from the book.tex file that also resides at the root.

There is a single book/references.bib file that includes all the citations that have been used in all book chapters, in order to avoid duplicate references and in order to facilitate checking for overall consistency.

The source latex code of each book chapter can be found in a subfolder of book/. For example book/chapter-introduction/ contains the introductory chapter, and so on.
If you want to change the contents of your book chapter, you need to work in those subfolders directly, and ALWAYS ensure that after having made local changes to your chapter, the book.tex file is still able to correctly compile the book (i.e. all chapters and all references).

The page limit of each book chapter will be 30 pages (including the first page containing the chapter title, authors and abstract; and also including all references for that chapter). Every book chapter author has a specific folder/directory corresponding to his/her specific chapter. You are expected to only commit/push changes to that particular directory (e.g. "book/chapter-introduction/" contains the introduction chapter of the book). Do not commit any changes to other directories (belonging to other chapters or to the front- or backmatter of the book) except if you have requested and received explicit permission from the book editors for doing so.

Latex packages and commands that are used for each chapter have been put in the preamble.tex file at the root of the repository, which is shared by all chapters. This avoids package incompatibilities and conflicts, and it allows all chapters to benefit from using the same set of commands.
