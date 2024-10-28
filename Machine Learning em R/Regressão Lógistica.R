                        ## MODELO REGRESSÃO LÓGISTICA ##
                        ################################
                        
## REGRESSÃO LOGÍSTICA ##
## É um modelo estatístico usado para prever a probabilidade ##
## de uma classe binária. como "inadiplente" ou "não inadiplente" ##
## com base em variáveis explicativas. ##
                                               
# 1 - INSTALANDO PACOTES NECESSÁRIOS #
install.packages("caTools")
install.packages("caret")

# 2 - CARREGANDO PACOTES NECESSÁRIOS #
library(caTools)
library(caret)

# 3 - CARREGANDO O DATASET #
credit_data <- read.csv("Endereço de Dataset")
credit_data$class <- as.factor(credit_data$class)

# 4 - DIVIDINDO OS DADOS EM TREINO(70%) E TESTE(30%) #
set.seed(123)
train_index <- createDataPartition(credit_data$class, p = 0.7, list = FALSE)
train_data <- credit_data[train_index, ]
test_data <- credit_data[-train_index, ]

# 5 - MODELO DE REGRESSÃO LOGÍSTICA #
logistic_model <- train (class ~., data = train_data, method = "glm", family = "binomial")
logistic_pred <- predict(logistic_model, test_data)

# 6 - MATRIZ DE CONFUSÃO #
confusionMatrix(logistic_pred, test_data$class)




