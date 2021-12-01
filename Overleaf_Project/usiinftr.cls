% -----------------------------------------------------------------------------
% LaTeX class for the Efficient Computational Algorithms Course Fall 2020
% Faculty of Informatics of the Universit� della Svizzera italiana
% 
% Timothy Holt <timothy.holt@usi.ch
% -----------------------------------------------------------------------------
%%
%% This file is 'usiinfTR.cls'
%% 
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{usiinftr}[2010/04/01 v. 1.0.0 USI Informatics Technical Report class]

%%
%% use option "coverpage" to create an individual first page with logo, title, and abstract
%%
\newif\if@coverpage
\@coverpagefalse
\DeclareOption{coverpage}{\@coverpagetrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}} 
\ProcessOptions\relax
\LoadClass{article}

%%
%% font settings
%%
\RequirePackage[T1]{fontenc}
\RequirePackage[latin1]{inputenc}
\RequirePackage[utopia]{mathdesign}
\renewcommand{\sfdefault}{uop}

%%
%% section headers in sans-serif
%%
\RequirePackage[sf,bf,small]{titlesec}

%%
%% page settings
%%
\RequirePackage[a4paper,hscale=0.75,vscale=0.8]{geometry}

%%
%% language settings
%%
\RequirePackage[british]{babel}

%%
%% captions settings
%%
\RequirePackage[small,sf,bf]{caption}

%%
%% hyperref settings
%%
\RequirePackage[colorlinks,linkcolor=blue,citecolor=blue,urlcolor=blue]{hyperref}

%%
%% graphics settings
%%
\RequirePackage{graphicx}

%%
%% default setting for "\date{}"
%%
\def\monthname{\ifcase\month \or
January\or February\or March\or April\or May\or June\or
July\or August\or September\or October\or November\or December\fi}
\def\@date{\monthname~\the\year}

%%
%% new commands to pass authors and affiliations
%%
\def\addtok#1#2{\global#1\expandafter{\the#1#2}}
\newcounter{n@authors}
\newtoks\@authors
\renewcommand{\author}[2]{%
  \stepcounter{n@authors}%
  \ifnum \then@authors > 1 \addtok\@authors{, } \fi%
  \addtok\@authors{#1$^{\,#2}$}%
}
\newcounter{n@affiliations}
\newtoks\@affiliations
\newcommand{\affiliation}[2]{%
  \stepcounter{n@affiliations}%
  \ifnum \then@affiliations > 1 \addtok\@affiliations{\newline} \fi%
  \addtok\@affiliations{$^{#1\,}$#2}%
}

%%
%% useful macros
%%
\def\INF{Faculty of Informatics}
\def\USI{Universit� della Svizzera italiana}
\def\USIINF{\INF, \USI, Switzerland}
\def\USIINFTR{Advanced Topics In Machine Learning, Fall 2021}

% \def\ENG{Faculty of Engineering}
% \def\FAU{Friedrich-Alexander Universität Erlangen-Nürnberg}
% \def\FAUENG{\ENG, \FAU, Germany}

%%
%% title page
%%
\renewcommand{\maketitle}{ 
  \newpage
  \null
  \noindent\includegraphics[width=\textwidth]{figures/HeaderUSI_FAU}%
  \if@coverpage\thispagestyle{empty}\setcounter{page}{0}\fi%
  \vskip2em%
  \noindent\emph{\large\USIINFTR}
  \if@coverpage\vskip3em\else\vskip.75em\fi%
  {\noindent\LARGE\sffamily\bfseries\@title\par}%
  \if@coverpage\vskip2em\else\vskip1em\fi%
  {\noindent\large\the\@authors\par}%
  \if@coverpage\vskip2em\else\vskip1em\fi%
  {\noindent\small\the\@affiliations}
  \if@coverpage\vskip4em\else\vskip2em\fi%
}

%%
%% new command to pass tech report number
%%
% \newcommand{\TRnumber}[1]{\gdef\@TRnumber{#1}}
% \newcommand{\@TRnumber}{\@latex@error{No \noexpand\TRnumber given}\@ehc}

%%
%% abstract 
%%
\renewenvironment{abstract}{
  \hrule%
  \if@coverpage\vskip1.5em\else\vskip1em\fi%
  \noindent%
  \begin{minipage}[t]{0.69\textwidth}
  \small\noindent%
  {\sffamily\bfseries\abstractname\if@coverpage\vskip.9em\else\vskip.4em\fi}%\vskip.4em}%
  \noindent\ignorespaces%
}{
  \end{minipage}\hfill%
  \begin{minipage}[t]{0.29\textwidth}%
  \small\noindent% 
  {\sffamily\bfseries Report Info\if@coverpage\vskip1em\else\vskip.5em\fi}%\vskip.5em}%
  \footnotesize\noindent% 
  \emph{Published}\\
  \@date\par\smallskip%
  \emph{Course}\\
  Advanced Topics In Machine Learning\\
  Fall 2021\par\smallskip%
  \emph{Institutions}\\
  \INF\\
  Universit\`a della Svizzera italiana\\
  Lugano, Switzerland\par
  \emph{\&}\\
  Faculty of Engineering\\
  Friedrich-Alexander Universit\"at\\
  Erlangen-N\"urnberg, Germany\par\smallskip
  % \emph{Online Access}\\
  % \hspace*{0.5pt}\href{http://www.inf.usi.ch/techreports/}{www.inf.usi.ch/techreports}
  \end{minipage}\par%
  \if@coverpage\vskip1.5em\else\vskip1em\fi%
  \hrule%
  \if@coverpage\newpage\else\vskip2em\fi%
}

%%
%% bibliography settings
%%
\renewenvironment{thebibliography}[1]
  {\subsection*{\refname}\small%
  \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
  \list{\@biblabel{\@arabic\c@enumiv}}%
       {\itemsep 2pt plus 1pt minus 1pt%
        \parsep 1pt%
        \settowidth\labelwidth{\@biblabel{#1}}%
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \@openbib@code
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m}
  {\def\@noitemerr
   {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist}

%%
%% backmatter
%%
\newcommand{\tritem}[2]{{\item #1\\\emph{#2}}}
\newcounter{trlist@cnt}
\newcommand{\skiptritem}{\stepcounter{trlist@cnt}}
\newenvironment{trlist}[1]
{\subsection*{#1}\small\begin{list}{\thetrlist@cnt.\stepcounter{trlist@cnt}}{\setlength{\leftmargin}{2.5em}\setcounter{trlist@cnt}{1}}}
{\end{list}}
\newcommand{\backmatter}{%
  \newpage\pagestyle{empty}%
  \section*{\USIINFTR}
  \input{techreportlist}
}

