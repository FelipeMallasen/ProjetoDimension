

echo "         __  __       _ _                       _____           _       _    "
echo "        |  \/  |     | | |                     / ____|         (_)     | |   "
echo "        | \  / | __ _| | | __ _ ___  ___ _ __ | (___   ___ _ __ _ _ __ | |_  "
echo "        | |\/| |/ _` | | |/ _` / __|/ _ \ '_ \ \___ \ / __| '__| | '_ \| __| "
echo "        | |  | | (_| | | | (_| \__ \  __/ | | |____) | (__| |  | | |_) | |_  "
echo "        |_|  |_|\__,_|_|_|\__,_|___/\___|_| |_|_____/ \___|_|  |_| .__/ \__| "
echo "                                                               | |           "
echo "                                                               |_|           "

PURPLE='0;35'
NC='\033[0m' 

#  Instalação do Docker
echo "$(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Conferindo a versão do Docker"
docker -v
if [ $? -eq 0 ]
then
echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Docker já instalado."
else
echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Docker não instalado"
echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Gostaria de instalar o Docker? S/n "
read inst
if [ \"$inst\" == \"s\" ]
then
echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Iniciando a instalação do Docker..."
sleep 2
sudo apt update && sudo apt install docker.io -y

echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Instalação completa do Docker"
sleep 2
else echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Você escolheu não instalar"
fi
fi

echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Inicializando o Docker"
sleep 2
sudo systemctl start docker
sudo systemctl enable docker
echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Docker foi inicializado"
sleep 2 

echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Instalação da imagem MySQL"
echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Verificação se existe a Imagem MySQL"

if [[ ! "$(sudo docker image inspect mysql:5.7)" ]]
then
echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Imagem MySQL não instalado"

echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Gostaria de fazer a instalação S/n "
read inst
if [ \"$inst\" == \"s\" ]
then
echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Iniciando a instalação do MySQL..."
sleep 2
sudo docker pull mysql:5.7

echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Instalação completa do MySQL"
sleep 2
else
echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Imagem MySQL já instalado."
fi
fi



echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Configurando o ambiente/Container para o MySQL"

if [[ ! "$(sudo docker ps -aqf "name=ContainerDimensionBD")" ]]
    then
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Container inexistente"
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Gostaria de criar o Container?  S/n "
        read inst
        if [ \"$inst\" == \"s\" ]
            then
            echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Iniciando a criação do ContainerDimensionBD..."
            sleep 2
            sudo docker run -d -p 3306:3306 --name ContainerDimensionBD -e "MYSQL_DATABASE=dimensionBD" -e "MYSQL_ROOT_PASSWORD=" mysql:5.7
            
            echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Instalação completa do MySQL"
            sleep 2
    else
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Container MySQL já existe."
    fi
fi

# Startando o Container
#echo \"Inicializando o Container MySQL\"
# Pegando o ID do container
#CONTID=$(sudo docker ps -aqf "name=ContainerDimensionBD")
#sudo docker start CONTID
#sudo docker exec -it  ${CONTID} bash

echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Instalação de Java"
sleep 5

echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Conferindo a versão do Java"
# javac -version
# checar se tem instalado a img
if [[ ! "$(sudo docker image inspect openjdk:11)" ]]
    then
    echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Instalação da imagem do Java será iniciado"
    sudo docker pull openjdk:11

    else
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Imagem Java já foi instalada"
    fi
    
    echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Verificação se Container Java existe"
    if [[ ! "$(sudo docker ps -aqf "name=ContainerDimensionJDK")" ]]
        then
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Agora preciso que você execute alguns comandos um de cada vez"
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Primeiro execute o comando: git clone https://github.com/pedro-duo/DimensionJar.git"
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)O segundo comando é o: cd DimensionJar"    
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)O terceiro comando é o: cd Api"
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)O quarto comando é o: cd target"
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Agora chegou a hora de executar o nosso Jar, é importante frizar que para parar o processo basta dar um Ctrl + C..."
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Digite o comando: java -jar DimensionJar.jar"
            sudo docker run -t -d --name ContainerDimensionJDK openjdk:11
            sudo docker exec -it ContainerDimensionJDK bash
        else
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Agora preciso que você execute alguns comandos um de cada vez"
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Primeiro execute o comando: git clone https://github.com/pedro-duo/DimensionJar.git"
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)O segundo comando é o: cd DimensionJar"
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)O terceiro comando é o: cd Api"
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)O quarto comando é o: cd target"
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Agora chegou a hora de executar o nosso Jar, é importante frizar que para parar o processo basta dar um Ctrl + C..."
        echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Digite o comando: java -jar DimensionJar.jar"
            echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Container já existe, iniciando o Container..."
            sudo docker exec -it ContainerDimensionJDK bash
            #echo \"Container foi iniciado!\"
        fi    
    
# FINALIZAÇÃO DO SCRIPT

# INICIALIZAÇÃO PARA BAIXAR O REPOSITÓRIO E INICIAR O JAR
echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Finalização da instalação do Java e o Docker"
sleep 2


git clone https://github.com/pedro-duo/DimensionJar.git
cd DimensionJar
cd Api\ Conexão/
cd target
echo \"Executando Aplicação Dimension...\"
java -jar DimensionJar.jar

sleep 5
java -jar DimensionJar.jar stop

echo "(tput setaf 10)[Mallasen assistant]:$(tput setaf 7)Obrigado por utilizar MallasenScript!;)"