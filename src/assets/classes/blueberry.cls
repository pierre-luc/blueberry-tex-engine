% blueberry.cls
% Cette classe latex doit soit se trouver dans le repertoire
% courant ainsi que le logo soit être dans votre path latex
\ProvidesClass{blueberry}

% Utilisation de la classe article comme base
\LoadClass[10pt]{article}

% utilisation des convention française
\usepackage[utf8x]{inputenc}
\usepackage[francais]{babel}
%\AddThinSpaceBeforeFootnotes % à insérer si on utilise \usepackage[french]{babel}
%\FrenchFootnotes % à insérer si on utilise \usepackage[french]{babel}
\usepackage{color}
\usepackage{pdflscape}
\usepackage{hyperref}
\usepackage{graphicx}
\usepackage[export]{adjustbox}
\usepackage[table]{xcolor}
\usepackage[toc,page]{appendix}
\renewcommand{\appendixpagename}{Annexes}
\renewcommand{\appendixtocname}{Annexes}

% Pour les calculs
\usepackage[nomessages]{fp}

% Float remplacé par floatrow ?
%\usepackage{float}
\usepackage{floatrow}
\floatsetup[table]{capposition=bottom}

\definecolor{secondarycolor}{RGB}{156,196,56}
\definecolor{blueberry}{RGB}{95,111,178}
\definecolor{darkblueberry}{RGB}{9,23,82}
\definecolor{littlegrey}{RGB}{51, 51, 3}
\definecolor{conformColor}{RGB}{55, 148, 25}
\definecolor{nonConformColor}{RGB}{208, 59, 59}
\definecolor{respAColor}{HTML}{EC6262}
\definecolor{respRColor}{HTML}{A4E0F1}
\definecolor{respCColor}{HTML}{FFBF6D}
\definecolor{respIColor}{HTML}{DDF998}
\definecolor{bigLineColor}{HTML}{B98759}
\definecolor{grayOneLineOnTwo}{RGB}{215, 215, 215}

\DeclareOption{orange}{
    \definecolor{secondarycolor}{RGB}{255,164,45}
}
\DeclareOption{gold}{
    \definecolor{secondarycolor}{RGB}{237,223,22}
}
\DeclareOption{red}{
    \definecolor{secondarycolor}{RGB}{231,47,115}
}
\DeclareOption{blue}{
    \definecolor{secondarycolor}{RGB}{118,202,225}
}
\ProcessOptions

\usepackage{siunitx}
\sisetup{group-separator = {\ }}
\sisetup{group-minimum-digits = 3}

\usepackage{eurosym}

\usepackage[T1]{fontenc}
\usepackage{titlesec}
\usepackage{etoolbox}
\makeatletter
\patchcmd{\ttlh@hang}{\parindent\z@}{\parindent\z@\leavevmode}{}{}
\patchcmd{\ttlh@hang}{\noindent}{}{}{}
\makeatother

\titleformat{\section}
{\color{blueberry}\normalfont\Large\bfseries} %section title
{\color{secondarycolor}\thesection}{1em}{}         %section number


%Macro outil, ne devrait pas être utiliser en dehors de ce fichier.
\def\addtomacro#1#2{\edef#1{\unexpanded\expandafter{#1#2}}}

% champs supplmentaires pour la page de garde:
% projet, filiere, version, relecteur et logo.
% La command \histentry{version}{date}{description}
% permet d'ajouter des entrees aux tableau sur la page de garde.
\makeatletter
    \newcommand{\projet}[1]{\def \@projet {#1}}
    \newcommand{\schoolyear}[1]{\def \@schoolyear {#1}}
    \newcommand{\authorFooter}[1]{\def \@authorFooter {#1}}
    \newcommand{\projdesc}[1]{\def \@projdesc {#1}}
    \newcommand{\pitch}[1]{\def \@pitch {#1}}
    \newcommand{\filiere}[1]{\def \@filiere {#1}}
    \newcommand{\version}[1]{\def \@version {#1}}
    \newcommand{\relecteur}[1]{\def \@relecteur {#1}}
    \newcommand{\signataire}[1]{\def \@signataire {#1}}
    \newcommand{\logo}[1]{\def \@logo {#1}}
    \newcommand{\histentry}[3]{\addtomacro{\@history}{#1&#2&#3\\\hline}}
    \projet{}
    \schoolyear{}
    \authorFooter{}
    \filiere{}
    \version{}
    \relecteur{}

    \logo{assets/ressources/logoText.png}
    \DeclareOption{orange}{
        \logo{assets/ressources/logoTextOrange.png}
    }
    \DeclareOption{gold}{
        \logo{assets/ressources/logoTextGold.png}
    }
    \DeclareOption{red}{
        \logo{assets/ressources/logoTextRed.png}
    }
    \DeclareOption{blue}{
        \logo{assets/ressources/logoTextBlue.png}
    }
    \ProcessOptions


    \signataire{}
    \projdesc{}
    \pitch{}
    \def \@history {} % Initialise l'historique a vide.
\makeatother

% marges
\usepackage[top=1.1in,bottom=1.2in,left=1.25in,right=1.25in]{geometry}

% indentations
\usepackage{indentfirst}
\setlength{\parindent}{18pt}
\setlength{\parskip}{3pt}

% espacements
\usepackage{setspace}

% gestion des references
\usepackage{varioref}
\usepackage{hyperref}

% gestion des figures
\usepackage{graphicx}

% gestion bibliography
\usepackage{natbib}

% gestion de la dernière page
\usepackage{lastpage}

% forcer les images à se placer au bon endroit
\usepackage{float}


% entête et pagination
\makeatletter
    \usepackage{fancyhdr}
    \pagestyle{fancy}
    \setlength{\headheight}{14pt}
    \renewcommand{\headrulewidth}{1pt}% 2pt header rule
    \renewcommand{\headrule}{\hbox to\headwidth{%
       \color{secondarycolor}\leaders\hrule height \headrulewidth\hfill}}

   \renewcommand{\footrulewidth}{1pt}% 2pt header rule
   \renewcommand{\footrule}{\hbox to\headwidth{%
      \color{secondarycolor}\leaders\hrule height \footrulewidth\hfill}}

    \renewcommand{\footrulewidth}{\headrulewidth}
    \fancyhf{}

    \fancyhead[L]{{\color{darkblueberry} \@filiere}}
    \fancyhead[C]{{\color{darkblueberry} \@projet\\\@title - \@version}}
    \fancyhead[R]{
      \ifx \@logo \@empty
      \else
      \includegraphics[width=0.15\textwidth]{\@logo}
      \fi
    }

    \fancyfoot[L]{}
    \fancyfoot[R]{{\color{darkblueberry} \thepage / \pageref{LastPage}}}
    \vspace{1cm}
\makeatother

% Permet de conditionner la mise en page de la page de garde.
\usepackage{ifthen}

%Macro commande pour la création d'un tableau de type fiche
\newcommand{\fiche}[9] {
	\noindent
\begin{tabular}{|p{3.5cm}| p{1cm} | p{3cm} | p{.5cm} | p{7cm}|}
\hline
\multicolumn{2}{|>{\color{white}\columncolor{blue}}l|}{\bfseries{ Nom}} & \multicolumn{3}{>{\color{white}\columncolor{blue}}l|}{\bfseries{#1}}\\
\hline
\multicolumn{2}{|l|}{\bfseries{\bfseries{Acteurs concernés}}} & \multicolumn{3}{m{10.5cm}|}{#2}\\
\hline
\multicolumn{2}{|l|}{\bfseries{\bfseries{Description}}} & \multicolumn{3}{m{10.5cm}|}{#3}\\
\hline
\multicolumn{2}{|l|}{\bfseries{\bfseries{Préconditions}}} & \multicolumn{3}{m{10.5cm}|}{#4}\\
\hline
\multicolumn{2}{|l|}{\bfseries{\bfseries{Evénements déclenchants}}} & \multicolumn{3}{m{10.5cm}|}{#5}\\
\hline
\multicolumn{2}{|l|}{\bfseries{\bfseries{Conditions d'arrêt}}} & \multicolumn{3}{m{10.5cm}|}{#6}\\
\hline
\multicolumn{5}{|>{\columncolor[gray]{.7}}l|}{\bfseries{\bfseries{Description du flot d'événements principal:}}}\\
\hline
\multicolumn{3}{|>{\columncolor[gray]{.7}}c|}{\bfseries{\bfseries{Acteur(s)}}} & \multicolumn{2}{>{\columncolor[gray]{.7}}c|}{\bfseries{\bfseries{Système}}}\\
\hline
\multicolumn{3}{|p{7.5cm}|}{#7} & \multicolumn{2}{p{7.5cm}|}{#8}\\
\hline
\bfseries{Flots d'exceptions:} & \multicolumn{4}{|p{11.5cm}|}{#9}\\
\hline
\end{tabular}
\\
}


% Mecanique de fiche avec une image pour la partie
% Description du flot d ’événements principal.
\newcommand{\ficheGraphic}[9] {
	\noindent
\begin{tabular}{|p{3.5cm}| p{1cm} | p{3cm} | p{.5cm} | p{7cm}|}
\hline
\multicolumn{2}{|>{\color{white}\columncolor{blue}}l|}{\bfseries{ }} & \multicolumn{3}{>{\color{white}\columncolor{blue}}l|}{\bfseries{#1}}\\
\hline
\multicolumn{2}{|l|}{\bfseries{\bfseries{Acteurs concern\'{e}s}}} & \multicolumn{3}{m{10.5cm}|}{#2}\\
\hline
\multicolumn{2}{|l|}{\bfseries{\bfseries{Description}}} & \multicolumn{3}{m{10.5cm}|}{#3}\\
\hline
\multicolumn{2}{|l|}{\bfseries{\bfseries{Pr\'{e}conditions}}} & \multicolumn{3}{m{10.5cm}|}{#4}\\
\hline
\multicolumn{2}{|l|}{\bfseries{\bfseries{Ev\`{e}nements d\'{e}clenchants}}} & \multicolumn{3}{m{10.5cm}|}{#5}\\
\hline
\multicolumn{2}{|l|}{\bfseries{\bfseries{Conditions d'arr\^{e}t}}} & \multicolumn{3}{m{10.5cm}|}{#6}\\
\hline
\multicolumn{5}{|>{\columncolor[gray]{.7}}l|}{\bfseries{\bfseries{Description du flot d'\'{e}v\`{e}nements principal:}}}\\
\hline
\multicolumn{5}{|c|}{}\\
\multicolumn{5}{|c|}{\bfseries{\bfseries{\includegraphics[scale=#7]{#8}}}}\\
\hline
\bfseries{Flots d'exceptions:} & \multicolumn{4}{|p{11.5cm}|}{#9}\\
\hline
\end{tabular}
\\
}

% Tableau pour la matrice de conformité.
\newcommand{\bbMatrix}[6] {
\begin{table}[H]
\centering
\resizebox{\textwidth}{!}{%
\def\arraystretch{2}
\begin{tabular}{lcccc}
\hline
% Entete
\rowcolor{secondarycolor}
\multicolumn{1}{|c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Niveau}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{ID}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Exigence}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Conformité}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Version}}}
\\ \hline
% Contenu
\multicolumn{1}{|c|}{\textbf{\lbrack #1\rbrack}} & % Catégorie
\multicolumn{1}{c|}{\textbf{#2}} & % Identifiant
\multicolumn{1}{c|}{\parbox{0.9\textwidth}{\vspace{.2\baselineskip}#3\vspace{.2\baselineskip}}} & % Contenu
\multicolumn{1}{c|}{
	\ifnum0=#4\relax
		\parbox{0.18\textwidth}{\cellcolor{nonConformColor}\centering\textbf{Non-Conforme}}
	\else
		\parbox{0.18\textwidth}{\cellcolor{conformColor}\centering\textbf{Conforme}}
	\fi
} & % Conformité
\multicolumn{1}{c|}{\textbf{#5}} % Version
\\ \hline
% Justification
\multicolumn{5}{|l|}{\parbox{1.5\textwidth}{\vspace{.2\baselineskip}#6\vspace{.2\baselineskip}}} % Justification
\\ \hline
\end{tabular}%
}
\end{table}
}

% Compteur pour le tableau des risques
\newcounter{riskCounter}
\newcommand{\printRiskCounter}{\protect\stepcounter{riskCounter}\arabic{riskCounter}}
% Environnement pour le tableau des risques
\newenvironment{riskTable}[1]
{
\begin{table}[H]
\caption{#1}
\begin{adjustbox}{width=1.18\textwidth,center}
%\centering
\def\arraystretch{1.5}
\rowcolors{2}{grayOneLineOnTwo}{white}
\begin{tabular}{|>{\textbf{\printRiskCounter}}c|llllllll}
\hline
\rowcolor{secondarycolor}
\multicolumn{1}{|r|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{\#}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Catégorie}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Origine}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Description}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Conséquences}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Réponse}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{P}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{I}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{C}}}
\\ \hline
}
{
\end{tabular}
\end{adjustbox}
\end{table}
}

% Ligne du tableau de risques.
\newcommand{\riskLine}[7] {
& % Numéro
\multicolumn{1}{c|}{\small#1} & % Catégorie
\multicolumn{1}{c|}{\parbox{0.1\textwidth}{\centering\vspace{.2\baselineskip}\small#2\vspace{.2\baselineskip}}} & % Origine
\multicolumn{1}{l|}{\parbox{0.25\textwidth}{\vspace{.2\baselineskip}\small#3\vspace{.2\baselineskip}}} & % Description
\multicolumn{1}{c|}{\parbox{0.25\textwidth}{\vspace{.2\baselineskip}\small#4\vspace{.2\baselineskip}}} & % Conséquences
\multicolumn{1}{l|}{\parbox{0.4\textwidth}{\vspace{.2\baselineskip}\small#5\vspace{.2\baselineskip}}} & % Réponse
\multicolumn{1}{c|}{\small\textbf{#6}} & % Probabilité
\multicolumn{1}{c|}{\small\textbf{#7}} & % Impact
\multicolumn{1}{c|}{\FPeval{\result}{round(#6 * #7, 1)}\small\textbf{\result}} % Criticité
\\ \hline
}


% Environnement pour le tableau des responsabilités
\newenvironment{respTable}[1]
{
\begin{table}[H]
\caption{#1}
\begin{adjustbox}{width=0.9\textwidth,center}
%\centering
\def\arraystretch{2}
\rowcolors{2}{grayOneLineOnTwo}{white}
\begin{tabular}{|c|c|c|c|c|c|c|c|}
\hline
\multicolumn{1}{|c|}{\color{littlegrey} \textbf{Tâches}} &
\cellcolor{secondarycolor}{\rotatebox[origin=c]{270}{\color{littlegrey} \textbf{\footnotesize Quentin Brodier}}} &
\cellcolor{secondarycolor}{\rotatebox[origin=c]{270}{\color{littlegrey} \textbf{\footnotesize Thomas Capet}}} &
\cellcolor{secondarycolor}{\rotatebox[origin=c]{270}{\color{littlegrey} \textbf{\footnotesize Hugo Lecomte}}} &
\cellcolor{secondarycolor}{\rotatebox[origin=c]{270}{\color{littlegrey} \textbf{\footnotesize Imane Mraihy}}} &
\cellcolor{secondarycolor}{\rotatebox[origin=c]{270}{\color{littlegrey} \textbf{\footnotesize Anthony Breant}}} &
\cellcolor{secondarycolor}{\rotatebox[origin=c]{270}{\color{littlegrey} \textbf{\footnotesize Pierre-Luc Blot}}} &
\rotatebox[origin=c]{270}{\color{littlegrey} \textbf{\footnotesize Equipe de développement}}% &
%\rotatebox[origin=c]{270}{\textbf{\footnotesize Equipe de sécurité}}
\\ \hline
}
{
\end{tabular}
\end{adjustbox}
\end{table}
}

% Ligne sur toute la largeur dans le tableau de responsabilité.
\newcommand{\respBigLine}[1] {
\multicolumn{8}{|c|}{\cellcolor{bigLineColor}\textbf{#1}}
\\ \hline
}

% Ligne normale dans le tableau de responsabilité
\newcommand{\respLine}[8] {
\multicolumn{1}{|c|}{\parbox{0.6\textwidth}{\vspace{.1\baselineskip}#1\vspace{.1\baselineskip}}} & % Tâche
\multicolumn{1}{c|}{\colorCell{#2}} & % Quentin
\multicolumn{1}{c|}{\colorCell{#3}} & % Thomas
\multicolumn{1}{c|}{\colorCell{#4}} & % Hugo
\multicolumn{1}{c|}{\colorCell{#5}} & % Imane
\multicolumn{1}{c|}{\colorCell{#6}} & % Anthony
\multicolumn{1}{c|}{\colorCell{#7}} & % Pierre-Luc
\multicolumn{1}{c|}{\colorCell{#8}}% & % Equipe de dev
%\multicolumn{1}{c|}{\colorCell{#9}}  % Securité
\\ \hline
}

% Macro de coloration de case
\newcommand{\colorCell}[1] {
\ifx #1I \cellcolor{respIColor}I \fi
\ifx #1A \cellcolor{respAColor}A \fi
\ifx #1R \cellcolor{respRColor}R \fi
\ifx #1C \cellcolor{respCColor}C \fi
}

% Environnement pour le tableau de récap des taches
\newenvironment{waitingTasksTable}
{
\begin{table}[H]
\begin{adjustbox}{width=\textwidth,center}
%\centering
\def\arraystretch{2}
\rowcolors{2}{grayOneLineOnTwo}{white}
\begin{tabular}{lcc}
\hline
\rowcolor{secondarycolor}
\multicolumn{1}{|c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Tâches}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Début (au plus tôt)}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Fin (au plus tard)}}}
\\ \hline
}
{
\end{tabular}
\end{adjustbox}
\end{table}
}

% Ligne sur toute la largeur dans le tableau de recap des taches
\newcommand{\waitingTasksBigLine}[1] {
\multicolumn{3}{|c|}{\cellcolor{bigLineColor}\textbf{#1}}
\\ \hline
}

% Ligne normale dans le tableau de recap des taches
\newcommand{\waitingTasksLine}[3] {
\multicolumn{1}{|c|}{\parbox{0.6\textwidth}{\vspace{.1\baselineskip}#1\vspace{.1\baselineskip}}} & % Tâche
\multicolumn{1}{c|}{#2} & % Début
\multicolumn{1}{c|}{#3} % Fin
\\ \hline
}

% Environnement pour le tableau de récap des fournitures
\newenvironment{waitingFurnituresTable}
{
\begin{table}[H]
\begin{adjustbox}{width=\textwidth,center}
%\centering
\def\arraystretch{2}
\rowcolors{2}{grayOneLineOnTwo}{white}
\begin{tabular}{cccc}
\hline
\rowcolor{secondarycolor}
\multicolumn{1}{|c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Fourniture}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Nature}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Examen}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Date}}}
\\ \hline
}
{
\end{tabular}
\end{adjustbox}
\end{table}
}

% Ligne normale dans le tableau de recap des fournitures
\newcommand{\waitingFurnituresLine}[4] {
\multicolumn{1}{|c|}{\parbox{0.5\textwidth}{\vspace{.2\baselineskip}#1\vspace{.2\baselineskip}}} & % Fourniture
\multicolumn{1}{c|}{\parbox{0.15\textwidth}{\centering\vspace{.2\baselineskip}#2\vspace{.2\baselineskip}}} & % Nature
\multicolumn{1}{c|}{\parbox{0.25\textwidth}{\centering\vspace{.2\baselineskip}#3\vspace{.2\baselineskip}}} & % Examen
\multicolumn{1}{c|}{#4} % Date
\\ \hline
}

% Environnement pour le tableau de récap des attendus
\newenvironment{waitingTable}
{
\begin{table}[H]
\begin{adjustbox}{width=\textwidth,center}
%\centering
\def\arraystretch{2}
\rowcolors{2}{grayOneLineOnTwo}{white}
\begin{tabular}{ccc}
\hline
\rowcolor{secondarycolor}
\multicolumn{1}{|c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Attendu}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Nature}}} &
\multicolumn{1}{c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Date limite de mise à disposition}}}
\\ \hline
}
{
\end{tabular}
\end{adjustbox}
\end{table}
}

% Ligne normale dans le tableau de recap des attendus
\newcommand{\waitingLine}[3] {
\multicolumn{1}{|c|}{\parbox{0.5\textwidth}{\vspace{.2\baselineskip}#1\vspace{.2\baselineskip}}} & % Attendu
\multicolumn{1}{c|}{\parbox{0.15\textwidth}{\centering\vspace{.2\baselineskip}#2\vspace{.2\baselineskip}}} & % Nature
\multicolumn{1}{c|}{#3} % Date
\\ \hline
}

% Environnement pour les tableaux de l'offre financière
\newenvironment{financesTable}[1]
{
\begin{table}[H]
\caption{#1}
\begin{adjustbox}{width=0.9\textwidth,center}
%\centering
\def\arraystretch{1.3}
\begin{tabular}{|c|c|c|c|c|}
\hline
\multicolumn{1}{|c|}{\cellcolor{secondarycolor}{\color{littlegrey} \textbf{Tâche}}} &
\cellcolor{secondarycolor}{\rotatebox[origin=c]{270}{\color{littlegrey} \textbf{Nombre de jours}}} &
\cellcolor{secondarycolor}{\rotatebox[origin=c]{270}{\color{littlegrey} \textbf{Total des personnes}}} &
\cellcolor{secondarycolor}{\rotatebox[origin=c]{270}{\color{littlegrey} \textbf{Nombre de responsable(s)}}} &
\cellcolor{secondarycolor}{\rotatebox[origin=c]{270}{\color{littlegrey} \textbf{Coût}}}
\\ \hline
}
{
\end{tabular}
\end{adjustbox}
\end{table}
}

% Ligne sur toute la largeur dans les tableaux de l'offre financière
\newcommand{\financesBigLine}[1] {
\multicolumn{5}{|c|}{\cellcolor{bigLineColor}\textbf{#1}}
\\ \hline
}

\DeclareRobustCommand{\officialeuro}{%
  \ifmmode\expandafter\text\fi
  {\fontencoding{U}\fontfamily{eurosym}\selectfont e}}

% Ligne de total dans les tableaux de l'offre financière
\newcommand{\financesTotalLine}[1] {
\multicolumn{4}{|c|}{\cellcolor{bigLineColor}\textbf{Total}} &
\multicolumn{1}{r|}{\cellcolor{grayOneLineOnTwo}\SI{#1} \officialeuro\textsubscript{v}}
\\ \hline
}

% Ligne normale dans les tableaux de l'offre financière
\newcommand{\financesLine}[5] {
\multicolumn{1}{|c|}{\parbox{0.6\textwidth}{\vspace{.1\baselineskip}#1\vspace{.1\baselineskip}}} & % Tâche
\multicolumn{1}{c|}{#2} & % Nb. jours
\multicolumn{1}{c|}{#3} & % Nb. personnes
\multicolumn{1}{c|}{#4} & % Nb. responsables
\multicolumn{1}{r|}{\SI{#5} \officialeuro\textsubscript{v}}   % Cout
\\ \hline
}

% page de garde
\makeatletter
\def \maketitle{%
    \begin{titlepage}
        \ifx \@logo \@empty
            \hfill
        \else
            \includegraphics[width=0.33\textwidth]{\@logo}
        \fi
        \ifx \@projet \@empty
            \relax
        \else
            \ifx \@projdesc \@empty
            \parbox[b][4em][b]{0.66\textwidth}{
                    \flushright
                    {\color{blueberry} {\Huge {\bfseries \@projet}}}
                }
            \else
                \parbox[b][4em][b]{0.66\textwidth}{
                    \flushright
                    \hfill
                    {\color{blueberry} {\Huge {\bfseries \@projet}}}
                    {\color{darkblueberry}    \newline {\@pitch}}
                }
            \fi
        \fi

        %~\vfill
        \vspace{5cm}
        \begin{center}
            \includegraphics[width=5cm]{assets/ressources/logoTravel.png}
        \end{center}
        \begin{center}
            \vspace{2em}
            \ifx \@title \@empty
                \relax
            \else
                {\color{blueberry} {\huge \textbf{\@title} {\Large \@version}}}\\
            \fi
            {\@date}\\
            \vspace{2em}
            \ifx \@author \@empty
                \relax
            \else
                Auteur(s): \@author\\
            \fi
            \ifx \@relecteur \@empty
                \relax
            \else
                Relecteur(s): \@relecteur\\
            \fi
            \ifx \@signataire \@empty
                \relax
            \else
                Approuv\'e par: \@signataire\\
            \fi
            \vspace{4cm}
            À l'attention de la Maîtrise d'Ouvrage\\
            \vspace{2.5cm}


            \includegraphics[width=3cm]{assets/ressources/logoUniv.png}\\

            \@schoolyear
            \vspace{3em}
            \ifx \@history \@empty
                \relax
            \else
                \newpage
                \begin{tabular}[t]{|c|c|p{10cm}|}
                    \hline
                    \rowcolor{secondarycolor} \textcolor{white} {\bfseries Version} & \textcolor{white} {\bfseries Date} & \textcolor{white} {\bfseries Changelog} \\
                    \hline
                    \@history

                    \hline
                \end{tabular}
            \fi
        \end{center}
        \vfill
    \end{titlepage}
}
\makeatother
