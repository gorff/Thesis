% uqthesis.cls - University of Queensland PhD Thesis LaTeX Class File.

% Copyright (C) 2004 Paul Cochrane
% 
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.
%   
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%    
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.


% Modified 2013 - Thomas A. Bell
% Addition of various options better suited to the present structure expected
% of thesis submitted to the Univeristy of Queensland.  This included defining
% the "honours" class option providing a simplified alternative structure specifically
% for honours thesis.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uqthesis}[2004/12/01 University of Queensland thesis LaTeX class]

% ifthenelse for if loops
\RequirePackage{ifthen}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Control Features  %%%
% Features defined here using \DeclareOption{indenitifer}
% may be controlled by passing the appropriate {identifier}
% to this class document at the time of access.
% For example:
% \documentclass [identifier1, identifier2, identifier3] {uqthesis}

% Is the thesis for Phd or Honours?
% The default setting is PhD.
\newcommand{\degreetext}{for the degree of Doctor of Philosophy}
\newcommand{\declarework}{This thesis is composed of my original work, and contains no material previously published or written by another person except where due reference has been made in the text. I have clearly stated the contribution by others to jointly-authored works that I have included in my thesis.\\\\
I have clearly stated the contribution of others to my thesis as a whole, including statistical assistance, survey design, data analysis, significant technical procedures, professional editorial advice, and any other original research work used or reported in my thesis. The content of my thesis is the result of work I have carried out since the commencement of my research higher degree candidature and does not include a substantial part of work that has been submitted to qualify for the award of any other degree or diploma in any university or other tertiary institution. I have clearly stated which parts of my thesis, if any, have been submitted to qualify for another award.\\\\
I acknowledge that an electronic copy of my thesis must be lodged with the University Library and, subject to the General Award Rules of The University of Queensland, immediately made available for research and study in accordance with the Copyright Act 1968.\\\\
I acknowledge that copyright of all material contained in my thesis resides with the copyright holder(s) of that material. Where appropriate I have obtained copyright permission from the copyright holder to reproduce material in this thesis.}
% Or you may use the honours option.
\DeclareOption{honours}{\renewcommand{\degreetext}%
{in partial fulfilment of the degree of Bachelor of Science with Honours}
\renewcommand{\declarework}%
{The work presented in this Thesis is, to the best of my knowledge and belief original, except as acknowledged in the text, and has not been submitted either in whole or in part, for a degree at this or any other university.}}

% print the supervisors name?
\newboolean{printsupervisor}
\setboolean{printsupervisor}{false}
\DeclareOption{printsupervisor}{\setboolean{printsupervisor}{true}}

% print the department under the degree title?
\newboolean{printdepartment}
\setboolean{printdepartment}{false}
\DeclareOption{printdepartment}{\setboolean{printdepartment}{true}}

% print the school under the degree title?
\newboolean{printschool}
\setboolean{printschool}{false}
\DeclareOption{printschool}{\setboolean{printschool}{true}}

% print a copyright page on the back of the title page?
\newboolean{copyrightpage}
\setboolean{copyrightpage}{false}
\DeclareOption{copyrightpage}{\setboolean{copyrightpage}{true}}

% print ``Examiner's copy'' on the title page?
\newboolean{examinerscopy}
\setboolean{examinerscopy}{false}
\DeclareOption{examinerscopy}{\setboolean{examinerscopy}{true}}

% use small caps for the title text?
\newboolean{titlesmallcaps}
\setboolean{titlesmallcaps}{false}
\DeclareOption{titlesmallcaps}{\setboolean{titlesmallcaps}{true}}

% finished processing options
\ProcessOptions\relax

% load the book class using a4paper
\LoadClass[12pt,a4paper]{book}

% set up margins (these are worked out from info from Printery)
\setlength{\oddsidemargin}{-1in}   \setlength{\evensidemargin}{-1in}
\addtolength{\oddsidemargin}{25mm} \addtolength{\evensidemargin}{20mm}
\setlength{\marginparwidth}{40pt}  \setlength{\marginparsep}{10pt}
\setlength{\topmargin}{-5mm}       \setlength{\headsep}{0.5in}
\setlength{\textheight}{227mm}     \setlength{\textwidth}{165mm}

\brokenpenalty=10000   % dunno what this does, maybe handy

% this stops one figure taking up a whole page and lets more text onto
% the one page when a figure exists
\renewcommand\floatpagefraction{0.8} %   Default = 0.5

% macros for defining the department, various dates and the title and
% author of the thesis.
\def\logo#1{\gdef\@logo{#1}}
\def\logoscale#1{\gdef\@logoscale{#1}}
\def\@title{}
\def\@author{}
\def\authorqual#1{\gdef\@authorqual{#1}}
\def\supervisor#1{\gdef\@supervisor{#1}}
\def\school#1{\gdef\@school{#1}}
\def\department#1{\gdef\@department{#1}}
\def\submitdate#1{\gdef\@submitdate{#1}}
\def\copyrightyear#1{\gdef\@copyrightyear{#1}} % \author, \title in report
\def\@submitdate{\ifcase\the\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space \number\the\year}
\def\@copyrightyear{\number\the\year}

%%% load the required packages
% fancyhdr for nice, fancy headings
\RequirePackage{fancyhdr}
% ccaption for good caption handling
\RequirePackage{ccaption}
% xspace so that spaces after commands are handled correctly
\RequirePackage{xspace}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Define Title Page %%%
\def\titlep{
    \thispagestyle{empty}
    
    % University logo at top of page
    \begin{figure}[h]
	\begin{center}
	\includegraphics[scale=\@logoscale]{\@logo}
	\end{center}
    \end{figure}
	\vfill
	
    % Document Title
    \begin{center}
        \ifthenelse{\boolean{titlesmallcaps}}
            {\huge\sc\expandafter{\@title}} % put in small caps
            {\Large\uppercase\expandafter{\@title}} % use standard title
    \end{center}
    \vfill
    
    % Author, Qualifications and Supervisor
    \begin{center}
        \textrm{\@author}\\
        \textrm{\@authorqual}
    \end{center}
    \ifthenelse{\boolean{printsupervisor}}{
    	\vspace{0.2in}
	 \begin{center}
        	\textrm{Under the supervision of}\\
        \textrm{\@supervisor}
    \end{center}
    }{}
    \vfill
    
    % Degree & Faculty Details
    \begin{center}
        \textsc{A thesis submitted to the University of Queensland\\
        \degreetext{}\\
    \ifthenelse{\boolean{printdepartment}}%
          {Department of \expandafter{\@department}\\}{}
     \ifthenelse{\boolean{printschool}}%
          {School of \expandafter{\@school}\\}{}
        \@submitdate\\}
        
    % Additional 'Examination' Statement
    \end{center}
    \ifthenelse{\boolean{examinerscopy}}{%
        \begin{center}
            \vfill
            {\LARGE \textsc{Examiner's Copy}}
        \end{center}%
        }{}
    \vfill
    \newpage}

%%%%%%%%%%%%%%%%%%%%%%%%%  Define Signature Page  %%%
% UQ declaration
\long\def\signature#1{%
\begin{center}
\begin{minipage}[t]{4in}
\parindent=0pt
\declarework
\par
\vspace{1in}
\hbox to 4in{\hfil\shortstack{\vrule width 3in height 0.4pt\\#1}}
\end{minipage}
\end{center}}

% Page Definition
\def\signaturepage{%
	\vskip.5in
	\signature{\@author}}

%%%%%%%%%%%%%%%%%%%%%%%%%  Generate Front Material  %%%
% The first three or four pages.
\def\titlepage{%
    \pagenumbering{roman}  % front matter is numbered roman
    \titlep
    \ifthenelse{\boolean{copyrightpage}}{%
        \newpage
        \vspace*{\fill}
        \begin{center}
            \copyright{} \@author, \@copyrightyear.
        \end{center}
        \begin{center}
            Typeset in \LaTeXe{}.
        \end{center}
        \normalsize
        \newpage
        \signaturepage}{}
}

% improved version of caption handling
\usepackage{ccaption}
\captionnamefont{\scshape}
\captionstyle{}
\makeatletter
\renewcommand{\fnum@figure}[1]{\quad\small\textsc{\figurename~\thefigure}:}
\renewcommand{\fnum@table}[1]{\quad\small\textsc{\tablename~\thetable}:}
\renewcommand{\@makecaption}[2]{%
\vskip\abovecaptionskip
\sbox\@tempboxa{#1: #2}%
\ifdim \wd\@tempboxa >\hsize
  \def\baselinestretch{1}\@normalsize
  #1: #2\par
  \def\baselinestretch{1.5}\@normalsize
\else
  \global \@minipagefalse
  \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
\fi
\vskip\belowcaptionskip}
\makeatother

% set the pagestyle to look good
\pagestyle{fancy}

%%%%% Fancyhdr stuff
% give the header a bit more room, otherwise LaTeX will spew on each page
\addtolength{\headheight}{2.5pt}
% define how headers are marked, for details, see fancyhdr docs
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}

% define where sections, chapters and pagenumbers are put
% see fancyhdr docs for details
% the \nouppercase stops book.cls making the contents, bibliography
% and index headers from being all in uppercase.
% The options used here are essentially that in Lamport's book, but
% with small caps for the headings.
\fancyhf{}
\fancyhead[LE,RO]{\nouppercase{\thepage}}
\fancyhead[LO]{\sc \nouppercase{\rightmark}}
\fancyhead[RE]{\sc \nouppercase{\leftmark}}

%%% other settings required for a thesis
% It's a references section, not a bibliography, hence redefine
% \bibname i.e. change ``Bibliography'' to ``References''
\renewcommand*{\bibname}{References}

% use 1.5 line spacing for the examiners copy
% single line spacing for the final copy
\ifthenelse{\boolean{examinerscopy}}{%
\renewcommand{\baselinestretch}{1.5}}%
{\renewcommand{\baselinestretch}{1}}
