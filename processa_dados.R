# --------------------------------------------------------------------------

# Carrega Pacotes

# --------------------------------------------------------------------------

# carrega pacotes
library(dplyr)
library(stringr)
library(readr)
library(purrr)
library(data.table)
library(tidyr)

# --------------------------------------------------------------------------

# Carrega Data Frames

# --------------------------------------------------------------------------

# Declara vetor de acordes
lista_acordes = list.files("dados_acordes_letras",
                           pattern = "*acordes.csv") %>%
  paste0("dados_acordes_letras/",.)

# Funcao para ler acordes
readdata <- function(fn){
  dt_temp <- fread(fn, sep=",", header = T, encoding = 'UTF-8')
  dt_temp = dt_temp[,.(Musicas,Acordes)]
  artista = gsub(".*\\/|_acordes.csv","",fn)
  dt_temp = dt_temp[, Artistas := artista]
  dt_temp = setcolorder(dt_temp, c("Artistas", "Musicas", "Acordes"))
  return(dt_temp)
}

# Carrega Acordes
mylist <- lapply(lista_acordes, readdata)
acordes <- do.call('rbind', mylist)


# Declara vetor de acordes
lista_letras = list.files("dados_acordes_letras",
                          pattern = "*letras.csv") %>%
  paste0("dados_acordes_letras/",.)

# Funcao para ler acordes
readdata <- function(fn){
  dt_temp <- fread(fn, sep=",", header = T, encoding = 'UTF-8')
  dt_temp = dt_temp[,.(Musicas,Palavras)]
  artista = gsub(".*\\/|_letras.csv","",fn)
  dt_temp = dt_temp[, Artistas := artista]
  dt_temp = setcolorder(dt_temp, c("Artistas", "Musicas", "Palavras"))
  return(dt_temp)
}

# Carrega Letras
mylist <- lapply(lista_letras, readdata)
df_letras <- do.call('rbind', mylist)
letras <- df_letras[- grep("span", df_letras$Palavras),] 

# --------------------------------------------------------------------------

# Limpeza do banco

# --------------------------------------------------------------------------

# Remove nas de acordes
acordes <- acordes %>% na.omit()

# Remove nas de letras
letras <- letras %>% na.omit()

# --------------------------------------------------------------------------

# Seleciona artistas em ordem alphabetica
artistas <- c("adoniran-barbosa", "angra", "amado-batista", "banda-calypso",
              "claudia-leitte", "banda-eva", "alceu-valenca", "ana-carolina",
              "anitta", "arlindo-cruz", "baden-powell", "barao-vermelho",
              "beth-carvalho", "bezerra-da-silva", "bonde-do-tigrao",
              "bruno-e-marrone", "caetano-veloso", "capital-inicial",
              "cartola", "cazuza", "cassia-eller",  "chico-buarque",
              "chitaozinho-e-xororo", "clara-nunes", "cordel-do-fogo-encantado",
              "chiclete-com-banana", "asa-de-aguia", "olodum", "timbalada",
              "araketu", "terrasamba", "criolo", "daniela-mercury", "djavan",
              "dj-marlboro", "dennis-dj", "dorival-caymmi",
              "dominguinhos", "fernando-sorocaba", "paulinho-da-viola",
              "ednardo", "elis-regina", "emicida", "falamansa","zeca-pagodinho",
              "gilbertp-gil", "gusttavo-lima", "gog", "gonzaguinha",
              "henrique-e-juliano", "ivete-sangalo", "jackson-do-pandeiro",
              "jorge-ben-jor", "jorge-mateus", "joao-nogueira", "lenine",
              "legiao-urbana", "los-hermanos", "luan-santana", "luiz-gonzaga",
              "joao-bosco", "marilia-mendonca", "marisa-monte", "marcelo-d2",
              "mc-catra", "mc-kevinho", "milton-nascimento", "mestre-ambrosio",
              "mv-bill", "nacao-zumbi", "nando-reis", "natiruts",
              "nelson-cavaquinho", "os-paralamas-do-sucesso", 
              "projota", "racionais-mcs", "ratos-de-porao", "raul-seixas",
              "o-rappa", "rzo", "charlie-brown-jr", "raimundos", "lulu-santos",
              "toquinho", "titas", "mutantes", "skank", "tom-jobim","elomar",
              "sepultura", "sabotage", "seu-jorge", "trio-nordestino",
              "vinicius-de-moraes", "victor-leo", "ze-ramalho", 
              "zeze-di-camargo-e-luciano") %>% sort()

# --------------------------------------------------------------------------

# seleciona 65 musicas para clusters de musicas
musicas_65 <- c("trem-das-onze", "descobri-que-te-amo", "vaca-profana",
                "canto-de-ossanha", "morena-tropicana","o-tempo-nao-para",
                "malandragem-da-um-tempo","metamorfose-ambulante",
                "vou-festejar","desde-que-samba-samba","garota-de-ipanema",
                "lanterna-dos-afogado","nao-existe-amor-em-sp","grajauex",
                "o-bebado-a-equilibrista", "como-nossos-pais","bala-com-bala",
                "cancao-da-america","o-morro-nao-tem-vez","esperando-na-janela",
                "xote-das-menina", "por-causa-de-voce","a-ordem-e-samba",
                "casa-de-marimbondo","o-telefone-tocou-novamente",
                "mas-que-nada","taj-mahal","filho-maravilha",
                "daniel-na-cova-dos-leoes","faroeste-caboclo",
                "jack-sou-brasileiro","dois-olhos-negros",
                "cerebro-eletronico","clube-da-esquina-no2",
                "fe-cega-faca-amolada","el-justiceiro","jardim-eletrico",
                "cegos-do-castelo",
                "bichos-escrotos","frevo-mulher","nao-vou-me-adaptar",
                "natiruts-reggae-power","meu-reggae-roots","reggae-music",
                "surfista-do-lago-paranoa","vamos-fugir","pescador-de-ilusoes",
                "minha-alma","o-que-sobrou-do-ceu",
                "manguetown","vamo-bate-lata","vida-loka-parte-2","nego-drama",
                "homem-na-estrada","ratamahatta","orgasmatron",
                "territory","mina-do-condominio","pretinha",
                "jackie-tequila","garota-nacional","pacato-cidadao",
                "homem-primata","samba-de-uma-nota-so","agua-de-beber")


# Amostra de 50 musicas
musicas_50 <- acordes %>% distinct(Musicas) %>% slice_sample(n = 50) %>% pull()

# --------------------------------------------------------------------------

# Transforma acordes em one hot encoding

# --------------------------------------------------------------------------

# Trasnforma em fator
data = acordes %>%
  select(Musicas, Acordes) %>%
  mutate(Acordes = as.factor(Acordes)) %>% 
  filter(Musicas %in% musicas_65)

# Transforma em dummy one hot encoding
dummie_acordes <- dcast(data = data, Musicas ~ Acordes, length)

# Imprime amostra do banco
head(dummie_acordes[,1:10])

# Dimensao do banco
dim(dummie_acordes)

# Escreve musicas_acordes
# write_csv(dummie_acordes, "musicas_acordes.csv")

# --------------------------------------------------------------------------

# Transforma letras em one hot encoding

# --------------------------------------------------------------------------

# Transforma em fator
data = letras[, .(Musicas, Palavras)]

# Limpa string
data[ , Palavras := tolower(Palavras)
][, Palavras := sub("^([[:alpha:]]*).*", "\\1", Palavras)]

# seleciona primeiras 200000
data = data %>% filter(Musicas %in% musicas_65)

# Transforma em dummy one hot encoding
dummie_palavras <- dcast(data = data, Musicas ~ Palavras, length) 

# Imprime amostra do banco
head(dummie_palavras[,1:10])

# Dimensao do banco
dim(dummie_palavras)

# Escreve musicas_palavras.csv
# write_csv(dummie_palavras, "musicas_palavras.csv")

# --------------------------------------------------------------------------

# Unifica acordes e palavras em um dataframe

# --------------------------------------------------------------------------

# Unifica dummies de acordes e palavras
dummie <- data.frame(dummie_palavras[1:62, 5:2493],
                     dummie_acordes[1:62, 2:298])

# Recupera nome de musicas
musicas <- dummie_palavras %>% select(Musicas) %>%  pull()

# Escreve arquivo
# write_rds(musicas, "musicas")

# Atribui nome de linhas
row.names(dummie) <- musicas

# Imprime amostra do banco
dummie[1:10, 1:10]

# Dimensao do banco
dim(dummie)

# Escreve dummie
# write_csv(dummie, "musicas_acordes_palavras.csv")

# --------------------------------------------------------------------------
