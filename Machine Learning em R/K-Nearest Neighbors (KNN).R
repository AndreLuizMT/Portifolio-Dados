                        ## MODELO K-NEAREST NEIGHBORS (KNN) ##
                        ######################################
                        

## K-NEAREST NEIGHBORS (KNN) ##
## É um algoritmo de classificação não paramétrico e baseado em instância ##
## que classifica um novo ponto de dados com base na classe dos seus vizinhos ##
## mais próximos. Aqui estão algumas características marcantes do KNN ##
                        
                        
# 1 - INSTALANDO PACOTES NECESSÁRIOS #
install.packages("class")
install.packages("caTools")
install.packages("caret")

# 2 - CARREGANDO PACOTES NECESSÁRIOS #
library(class)
library(caTools)
library(caret)

# 3 - CARREGANDO O DATASET #
credit_data <- read.csv("Endereço do Dataset")
credit_data$class <- as.factor(credit_data$class)

# 4 - DIVIDINDO OS DADOS EM TREINO E TESTE #
set.seed(123)
train_index <- createDataPartition(credit_data$class, p = 0.7, list = FALSE)
train_data <- credit_data[train_index, ]
test_data <- credit_data[-train_index, ]

# 5 - SELECIONANDO APENAS COLUNAS NUMÉRICAS PARA NORMALIZAÇÃO #
numeric_cols <- sapply(train_data, is.numeric)
train_data_normalized <- scale(train_data[, numeric_cols])
test_data_normalized <- scale(test_data[, numeric_cols])

# 6 - APLICANDO KNN #
k_value <- 3 
train_data_final <- data.frame(train_data_normalized, class = train_data$class)
test_data_final <- data.frame(test_data_normalized, class = test_data$class)

knn_pred <- knn(train = train_data_final[, -ncol(train_data_final)],
                test = test_data_final[, -ncol(test_data_final)],
                cl = train_data_final$class,
                k = k_value)

# 7 - MATRIZ DE CONFUSÃO #
confusionMatrix(knn_pred, test_data_final$class)





