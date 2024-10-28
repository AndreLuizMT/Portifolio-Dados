                        ###   MODELO RANDOM FOREST   ###
                        ################################
                        

## RANDOM FOREST ##
## É um algoritimo baseado em árvores de decisão que cria várias árvores   ##
## aleatórias e combina seus resultados para melhorar a precisão e reduzir ##
## o risco de overfitting.                                                 ##
 
                                               
# 1 - INSTALANDO PACOTES NECESSÁRIOS #
install.packages("caret")
install.packages("randomForest")


# 2 - CARREGANDO PACOTES NECESSÁRIOS #
library(caret)
library(randomForest)

# 3 - CARREGANDO O DATASET #
credit_data <- read.csv("Endereçodo Dataset")

# 4 - CONVERTER A COLUNA 'class' para fator (inadiplente ou não)
credit_data$class <- as.factor(credit_data$class)

# 5 - DIVIDINDO OS DADOS EM TREINO(70%) E TESTE(30%) #
set.seed(123)
train_index <- createDataPartition(credit_data$class, p = 0.7, list = FALSE)
train_data <- credit_data[train_index, ]
test_data <- credit_data[-train_index, ]

# 6 - Treinar modelo Random Forest #
set.seed(123)
rf_model <- randomForest(class ~., data = train_data, importance = TRUE)

# 7 - Exibir os resultados do modelo #
print(rf_model)

# 8 - Fazer predições no conjunto de teste #
predictions <- predict(rf_model, test_data)

# 9 - Avaliar a performace do modelo #
conf_matrix <- confusionMatrix(predictions, test_data$class)

# 10 - Exibir a matriz de confusão e as métricas de performace #
print(conf_matrix)

# 11 - Exibir a importância das variáveis #
importance(rf_model)








