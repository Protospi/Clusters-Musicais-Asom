# Clusters Musicais Asom

### Informações sobre o App

***
* Resumo

  * O aplicativo de clusters musicais Asom faz a contagem n-gramas de palavras
e acordes para uma lista de artistas e agrupa os artistas em clusters. O objetivo deste projeto foi construir algumas ferramentas para exploração de acordes e letras de artistas com intuito de desenvolver um sistema de recomendação de artistas e músicas.
  * Contagens de palavras e acordes podem ser visualizados em gráficos
nos menus Acordes e Palavras.
  * Cluster de artistas por semelhança de acordes e letras podem ser visualizados no menu Clusters Gêneros.
  
***

* Funcionamento da Barra Lateral

  * O botão Número de Acordes seleciona a quantidade de acordes em sequência.
  * O botão Número de Palavras seleciona a quantidade de palavras em sequência.
  * O botão Artista seleciona um artista.
  * O botão Métrica de Distâncias seleciona a métrica de distância para o algoritmo de cluster.
  * O botão Número de Clusters seleciona em quantos cluster o algoritmo vai separar os artistas.
  * O botão Métrica de Ligação seleciona qual tipo de ligação o algoritmo de cluster considera para formar os grupos de artistas.

***  

* Banco de Dados
  * O banco de dados contém 77 observações e 8727 variáveis representando 77 artistas, 1404 acordes e 7323 palavras.
  * Foram amostradas no máximo 50 músicas de cada artista para remover outliers (artistas que possuíam 100 + musicas) com objetivo de equilibrar as amostras.
  * Total de 2310 músicas, sendo 2246 são tocadas por somente um artista e as outras 64 são tocadas por 1 ou mais artistas.
  * As cifras de violão e as letras foram extraídas do site:
    + https://www.cifraclub.com.br/
  * Notebook colab-python para extração dos dados:
    + https://colab.research.google.com/drive/1pau9BxN1mGoOwWvWT_Q1xIsijgkP3_Dj?usp=sharing
  
  
***

* Aplicativo em Produção
  + Cada segundo de um arquivo do tipo Mp3 possui 44.100 pontos de dados por segundo.
  + Em média um arquivo de áudio do tipo Mp3 possui 3 Mb.
  + Empresas como Spotify reivindicam que possuem dezenas de milhões de músicas em seu acervo.
  + Aplicar modelos de clusters em uma base de dados com esse volume seria praticamente impossível.
  + Uma possível solução seria reduzir a informação do áudio ou utilizar as letras e acordes.
  + O aplicativo pode ser utilizado como um sistema de recomendações para usuários de empresas de music stream.
  
  
***
