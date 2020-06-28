#!/bin/bash

sudo apt install nodejs npm python3-pip sbcl

pipi3 install --user jupyter jupyterlab
jupyter serverextension enable --user --py jupyterlab
jupyter labextension install @jupyter-widgets/jupyterlab-manager 
jupyter nbextension enable --user --py widgetsnbextension 
export PYTHON_USER_SITE=$(python -m site --user-site) 
mkdir -p ${PYTHON_USER_SITE}/notebook/static/components/codemirror/mode/maxima/ 
cp maxima.js ${PYTHON_USER_SITE}/notebook/static/components/codemirror/mode/maxima/ 
patch ${PYTHON_USER_SITE}/notebook/static/components/codemirror/mode/meta.js codemirror-mode-meta-patch 
cp maxima_lexer.py ${PYTHON_USER_SITE}/pygments/lexers/ 
patch ${PYTHON_USER_SITE}/pygments/lexers/_mapping.py pygments-mapping-patch 
curl -O https://beta.quicklisp.org/quicklisp.lisp 
sbcl --load quicklisp.lisp --load docker-install-quicklisp.lisp 
maxima --batch-string="load(\"load-maxima-jupyter.lisp\");jupyter_install();"
