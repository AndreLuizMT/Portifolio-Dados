                    ## MODELO GRADIENT BOOSTING MACHINE (GBM) ##
                    ############################################
                    
## GRADIENT BOOSTING MACHINE (GBM) ##
## É um algoritmo de aprendizado de máquina que constrói modelos preditivos na forma de um conjunto ##
## de árvores de decisão. O modelo é treinado de forma sequencial, onde cada árvore nova é criada para ##
## corrigir os erros cometidos pelas árvores anteriores. A principal característica do GBM é que ele ##
## minimiza a função de perda utilizando o gradiente descendente. ##
                    
# 1 - INSTALANDO PACOTES NECESSÁRIOS #
install.packages("gbm")
install.packages("caTools")
install.packages("caret")

# 2 - CARREGANDO PACOTES NECESSÁRIOS #
library(gbm)
library(caTools)
library(caret)

# 3 - CARREGANDO O DATASET #
credit_data <- read.csv("C:/Users/André PC/Desktop/Scripts R/Projeto ML com R/credit-g.csv")

# 4 - CONVERTENDO VARIÁVEIS CATEGÓRICAS PARA FATORES #
categorical_cols <- c("checking_status", "duration", "credit_history", "purpose",
                      "credit_amount", "savings_status", "employment", "installment_commitment", 
                      "personal_status", "other_parties", "residence_since","property_magnitude", 
                      "age", "other_payment_plans", "housing", "existing_credits",  
                      "job", "num_dependents", "own_telephone", "foreign_worker", 
                      "class")
credit_data[categorical_cols] <- lapply(credit_data[categorical_cols], as.factor)

# 5 - DIVIDINDO OS DADOS EM TREINO E TESTE #
set.seed(123)
train_index <- createDataPartition(credit_data$class, p = 0.7, list = FALSE)
train_data <- credit_data[train_index, ]
test_data <- credit_data[-train_index, ]

# 6 - MODELO GBM #
set.seed(321)
gbm_model <- train(
  class ~ ., data = train_data, method = "gbm",
  verbose = FALSE,
  trControl = trainControl(method = "cv", number = 5))


# 7 - PREDIÇÕES NO CONJUNTO DE TESTE #
gbm_pred <- predict(gbm_model, test_data)

# 8 - MATRIZ DE CONFUSÃO #
confusionMatrix(gbm_pred, test_data$class)