                        ## MODELO REDE NEURAL ARTIFICIAL (ANN) ##
                        #########################################
                        

## REDE NEURAL ARTIFICIAL (ANN) ##
## São modelos inspirados no funcionamento do cerébro humano. Elas são compostas por neurônios ##
## interconetados que podem aprender a partir de dados. Uma ANN é composta por uma camada de entrada, ##
## uma ou mais camadas ocultas e uma camada de saída. Cada conexão entr neurônios possui um peso que é ajustado ##
## durante o processo de treinamento, permitindo que a rede aprenda a mapear entradas para saídas. ##
                        
# 1 - INSTALANDO PACOTES NECESSÁRIOS #
install.packages("nnet")
install.packages("caTools")
install.packages("caret")

# 2 - CARREGANDO PACOTES NECESSÁRIOS #
library(nnet)
library(caTools)
library(caret)

# 3 - CARREGANDO O DATASET #
credit_data <- read.csv("Endereço do Dataset")

# 4 - CONVERTENDO VARIÁVEIS CATEGÓRICAS PARA FATORES #
categorical_cols <- c("checking_status", "duration", "credit_history", "purpose",
                      "credit_amount", "savings_status", "employment", "installment_commitment", 
                      "personal_status", "other_parties", "residence_since","property_magnitude", 
                      "age", "other_payment_plans", "housing", "existing_credits",  
                      "job", "num_dependents", "own_telephone", "foreign_worker", 
                      "class")
credit_data[categorical_cols] <- lapply(credit_data[categorical_cols], as.factor)

# 5 - SEPARANDO COLUNAS NUMÉRICAS PARA NORMALIZAÇÃO
numeric_cols <- setdiff(names(credit_data), categorical_cols)

# 6 - NORMALIZADO APENAS AS COLUNAS NUMÉRICAS
credit_data[numeric_cols] <- scale(credit_data[numeric_cols])

# 7 - DIVIDINDO OS DADOS EM TREINO E TESTE #
set.seed(123)
train_index <- createDataPartition(credit_data$class, p = 0.7, list = FALSE)
train_data <- credit_data[train_index, ]
test_data <- credit_data[-train_index, ]

# 8 - GARANTINDO QUE OS DADOS ESTEJAM EM FORMATO CORRETO (DATA FRAME)
train_data <- as.data.frame(train_data)
test_data <- as.data.frame(test_data)

# 9 - MANTENDO APENAS AS VARIÁVEIS MAIS IMPORTANTES #
selected_cols <- c("checking_status", "credit_history", "purpose", "savings_status", "employment", "class")
train_data <- train_data[selected_cols]
test_data <- test_data[selected_cols]

# 10 - MODELO DE REDE NEURAL COM UMA CAMADA OCULTA E 5 NEURÔNIOS #
set.seed(321)
ann_model <- nnet(class ~ ., data = train_data, size = 1, maxit = 100, linout = FALSE, decay = 0.01)

# 11 - GARANTINDO QUE AS VARIÁVEIS 'CLASS' NO TREINO E NO TESTE SEJAM FATORES COM MESMO NÍVEL
train_data$class <- factor(train_data$class, levels = c("bad", "good"))
test_data$class <- factor(test_data$class, levels = c("bad", "good"))

# 12 - PREDIÇÕES NO CONJUNTO DE TESTE #
ann_pred <- predict(ann_model, test_data, type = "class") 

# 13 - GARANTINDO QUE AS PREDIÇÕES ESTEJAM NO MESMO FORMATO
ann_pred <- factor(ann_pred, levels = c("bad", "good"))

# 14 - MATRIZ DE CONFUSÃO #
confusionMatrix(ann_pred, test_data$class)
                                       






