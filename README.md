# Template para apresentações no mestrado em Ciência da Computação - UEM . 

Esta template é customização do tema PaloAlto do Beamer

# Operações mais usadas


## Começar, ou seja, clonar o projeto pro seu computador:

git clone https://alexandrecandreani@bitbucket.org/alexandrecandreani/template-uem-slides.git



##Fazer commit, ou seja, gravar suas alterações no repositório:

make cleanall

git add .

git commit -am "<SUA MENSAGEM>"

git push -u origin master


##Gerar pdf:

make

##Atualizar repositório local

git pull

##Comparar  alterações dos últimos commits 

git log -p

##Resolver merges, ou seja, alguem alterou e salvou no servidor algum arquivo antes de você subir(git push) pro servidor. Esse commando vai tentar resolver automaticamente alguns conflitos

git merge 

##Resolver merge manualmente, isso vai abrir sua ferramenta de comparacao de arquivos pra vc resolver manualmente


git mergetool 

##Deleta arquivos intermediários, inclusive o final (main.pdf)

make cleanall

##Deletar arquivos intermediários menos o final (main.pdf)

make clean





