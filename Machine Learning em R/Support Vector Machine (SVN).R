                        ## MODELO SUPPORT VECTOR MACHINE (SVN) ##
                        #########################################
                        

## SUPPORT VECTOR MACHINE (SVN) ##
## É uma técnica de aprendizado de máquina muito poderosa para problemas  ##
## de classificação, especialmente quando se lida com classes que não são ##
## linearmente separáveis. Ele busca encontrar o hiperplano que melhor    ##
## separa as classes de dados, maximizando a margem entre as classes.     ##                       
                        
# 1 - INSTALANDO PACOTES NECESSÁRIOS #
install.packages("e1071")
install.packages("caret")
install.packages("caTools")

# 2 - CARREGANDO PACOTES NECESSÁRIOS #
library(e1071)
library(caret)
library(caTools)

# 3 - CARREGANDO O DATASET #
credit_data <- read.csv("Endereço do Dataset")
credit_data$class <- as.factor(credit_data$class)

# 4 - DIVIDINDO OS DADOS EM TREINO E TESTE #
set.seed(123)
train_index <- createDataPartition(credit_data$class, p = 0.7, list = FALSE)
train_data <- credit_data[train_index, ]
test_data <- credit_data[-train_index, ]

# 5 - MODELO SVM #
svm_model <- svm(class ~., data = train_data, kernel = "linear")

# 6 - PREVISÕES NO CONJUNTO DE TESTE #
svm_pred <- predict(svm_model, test_data)

# 7 - MATRIZ DE CONFUSÃO #
confusionMatrix(svm_pred, test_data$class)






