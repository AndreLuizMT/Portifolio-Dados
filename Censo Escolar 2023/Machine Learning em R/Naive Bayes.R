                        ## MODELO NAIVE BAYES ##
                        ########################
                        

## NAIVE BAYES ##
## É um classificador probabilistico baseado no Teorema de Bayes, que assume que as características ##
## são independentes entre si. Essa suposição de independência pode ser uma simplificação, mas o modelo ##
## costuma funcionar bem na prática, mesmo quando a suposição não é totalmente válida. ##
                        
                        
# 1 - INSTALANDO PACOTES NECESSÁRIOS #
install.packages("e1071")
install.packages("caTools")
install.packages("caret")

# 2 - CARREGANDO PACOTES NECESSÁRIOS #
library(e1071)
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

# 6 - MODELO NAIVE BAYES #
naive_bayes_model <- naiveBayes(class ~ ., data = train_data)

# 7 - PREDIÇÕES NO CONJUNTO DE TESTE #
naive_bayes_pred <- predict(naive_bayes_model, test_data)

# 8 - MATRIZ DE CONFUSÃO
confusionMatrix(naive_bayes_pred, test_data$class)







