                        ## MODELO XGBOOST ##
                        ####################
                        

## XGBOOST ##
## O XGBoost (Extreme Gradient Boosting) é um algoritmo de aprendizado de máquina altamente ##
## eficiente e flexível, frequentemente utilizado para tarefas de classificação e regressão. ##
## Ele é baseado em árvores de decisão e implementa um método de boosting, onde modelos fracos ##
## (geralmente árvores de decisão) são combinados para criar um modelo mais robusto. ##
                        
                        
                        
# 1 - INSTALANDO PACOTES NECESSÁRIOS #
install.packages("xgboost")
install.packages("caret")

# 2 - CARREGANDO PACOTES NECESSÁRIOS #
library(xgboost)
library(caret)

# 3 - CARREGANDO O DATASET #
credit_data <- read.csv("Endereço do Dataset")
credit_data$class <- as.factor(credit_data$class)

# 4 - DIVIDINDO OS DADOS EM TREINO E TESTE #
set.seed(123)
train_index <- createDataPartition(credit_data$class, p = 0.7, list = FALSE)
train_data <- credit_data[train_index, ]
test_data <- credit_data[-train_index, ]

# 5 - CONVERTENDO OS DADOS PARA MATRIZ #
train_matrix <- model.matrix(class ~ . - 1, data = train_data)
test_matrix <- model.matrix(class ~ . - 1, data = test_data)

# 6 - CONVERTENDO AS CLASSES PARA NUMÉRICO #
train_labels <- as.numeric(train_data$class) - 1
test_labels <- as.numeric(test_data$class) - 1

# 7 - MODELO XGBoost #
xgb_model <- xgboost(data = train_matrix, label = train_labels,
                     nrounds = 100, objective = "binary:logistic",
                     eval_metric = "logloss", verbose = 0)

# 8 - PREVISSÕES COM O MODELO #
xgb_pred_prob <- predict(xgb_model, test_matrix)
xgb_pred <- ifelse(xgb_pred_prob > 0.5, "good", "bad")

# 9 - MATRIZ DE CONFUSÃO #
confusionMatrix(factor(xgb_pred, levels = c("bad", "good")), test_data$class)





