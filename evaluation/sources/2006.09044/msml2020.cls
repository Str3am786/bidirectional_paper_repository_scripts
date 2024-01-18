\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{msml2020}[2019/07/25 v0.1 MSML 2020 Proceedings]

\@ifundefined{ifanonsubmission}{
  \newif\ifanonsubmission
  \anonsubmissionfalse
}{}

\@ifundefined{iffinalsubmission}{
  \newif\iffinalsubmission
  \finalsubmissionfalse
}{}

\DeclareOption{anon}{\anonsubmissiontrue}
\DeclareOption{final}{\finalsubmissiontrue}
\ProcessOptions\relax

\LoadClass[pmlr]{jmlr}

\jmlrvolume{vol 107}
\jmlryear{2020}
\jmlrproceedings{PMLR}{Proceedings of Machine Learning Research}

\ifanonsubmission
 \newcommand{\msmlauthor}[1]{}
 \author{author names withheld}
 \editor{Under Review for MSML 2020}
 \jmlrworkshop{1st Annual Conference on Mathematical and Scientific Machine Learning}
 \renewcommand{\acks}[1]{}
\else
 \newcommand{\msmlauthor}[1]{\author{#1}}
 \iffinalsubmission
  \editors{Jianfeng Lu and Rachel Ward}
  \jmlrworkshop{1st Annual Conference on Mathematical and Scientific Machine Learning}
 \fi
\fi



