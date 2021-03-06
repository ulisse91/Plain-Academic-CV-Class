%-------------------------------------------------------------------------
%                Identification
%-------------------------------------------------------------------------

\ProvidesClass{plain_academic_cv}[2022/05/03 v0.0.6 Plain Academic Curriculum Vitae Class]
\NeedsTeXFormat{LaTeX2e}




\newif\if@short
\DeclareOption{short}{\@shorttrue}

\def\@@ptsize{11pt}
\if@short
    \def\@@ptsize{8pt}
\fi



% \DeclareOption{11pt}{\def\@@ptsize{11pt}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass[\@@ptsize]{article}

\setcounter{secnumdepth}{0} %% Remove numbering from Section and Subsection

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PACKAGES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xparse}
\RequirePackage{ifthen}
% \RequirePackage{academicons}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{xcolor}
\RequirePackage{geometry}
\geometry{left=1.5cm, top=1cm, right=1.5cm, bottom=1.5cm, footskip=1cm}

\RequirePackage{enumitem}
\setlist[description]{font=\normalfont\itshape\space}
\setlist[itemize,enumerate]{leftmargin=*,itemsep=0pt,parsep=0pt}

\RequirePackage[
    backend=biber,
    style=numeric,
    sorting=ydnt,
    giveninits=true,
    defernumbers=true,
    maxbibnames=99]{biblatex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COLORS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\definecolor{lightgray}{HTML}{999999}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PERSONAL INFORMATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand*{\name}[1]{\def\@name{#1}}
\newcommand*{\department}[1]{\def\@department{#1}}
\newcommand*{\affiliation}[1]{\def\@affiliation{#1}}
\newcommand*{\mail}[1]{\def\@mail{#1}}
\newcommand*{\addressStreet}[1]{\def\@addressStreet{#1}}
\newcommand*{\addressCity}[1]{\def\@addressCity{#1}}
\newcommand*{\phonenumber}[1]{\def\@phonenumber{#1}}
\newcommand*{\homepage}[1]{\def\@homepage{#1}}
\newcommand*{\orcid}[1]{\def\@orcid{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HEADER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand*{\makecvheader}{%
    \begin{center}
        {\Huge\@name}
    \end{center}
    \noindent
    \ifthenelse{\isundefined{\@department}}{}{\@department}
    \hfill 
    \ifthenelse{\isundefined{\@phonenumber}}{}{\@phonenumber}
    \\
    \ifthenelse{\isundefined{\@affiliation}}{}{\@affiliation}
    \hfill
    \ifthenelse{\isundefined{\@mail}}{}{\href{mailto:\@mail}{\@mail}}
    \\
    \ifthenelse{\isundefined{\@addressStreet}}{}{\@addressStreet}
    \hfill 
    \ifthenelse{\isundefined{\@homepage}}{}{\href{https://\@homepage}{\textit{\@homepage}}}
    \\
    \ifthenelse{\isundefined{\@addressCity}}{}{\@addressCity}
    \hfill 
    \ifthenelse{\isundefined{\@orcid}}%
        {}{Orcid: 
        \href{https://orcid.org/\@orcid}{\@orcid}%\aiOrcid\acvHeaderIconSep\@orcid}%
        }
    \\
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FOOTER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\newcommand*{\footerstyle}[1]{{\color{lightgray} #1}}

\newcommand*{\makecvfooter}{%
    \fancyfoot{}
    \fancyfoot[L]{\footerstyle{\today}}
    \fancyfoot[C]{\footerstyle{\@name~~~·~~~Curriculum Vitae}}
    \fancyfoot[R]{\footerstyle{\thepage}}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LISTS (ITEMIZE/DESCRIPTIONS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NewDocumentCommand \idescr { m m m o } {
    \if@short
        \idescrshort{#1}{#2}{#3}
    \else 
        \item[#1] 
        $ $\\ 
        \textbf{#2} #3
        \IfNoValueTF{#4}{}{\\#4}
    \fi
}

% use second parameter for bullet point
\NewDocumentCommand \idescrshort { m o m m } {
    \item[#1\IfNoValueTF{#2}{ $\bullet$}{}] \IfNoValueTF{#3}{}{\textbf{#3}} #4
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMMANDS SHORT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\inputshort}[1]{
    \if@short
        %
    \else
        \input{#1}
    \fi
}

\if@short
    \let\oldsection\section
    \renewcommand{\section}[1]{
        \vspace{-.8cm}
        \oldsection{#1}
    }
    
    % 

    \renewcommand{\bibfont}{\small}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BIBLIOGRAPHY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setlength{\bibitemsep}{1.5ex}
\setlength{\bibhang}{2.5em}
\addbibresource{publications.bib}

\nocite{*}
 
\newcommand*{\printallpublications}{
    \printbibliography[heading={none}]
}

\newcommand*{\printpublications}[3]{
    \newrefcontext[labelprefix=#2]
    \printbibliography[heading={subbibliography},title={#3},type={#1}]
}

\newcommand*{\printpublicationscustom}[4]{
    \newrefcontext[labelprefix=#2]
    \printbibliography[heading={subbibliography},title={#3},type={#1},#4]
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%