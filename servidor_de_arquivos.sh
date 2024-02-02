#!/bin/bash
servidor()
{
echo "Criando servidor...."
sudo apt update
sudo apt install apache2 -y
echo "apache instalado!"

sudo apt install samba -y
echo "samba instalado!"

sudo apt install mariadb -y
echo "banco de dados instalado!"

sudo apt install phpmyadmin -y
echo "phpmyadmin instalado!"


escolha
}

novo_diretorio()
{
echo "criando diretorio...."
echo "De um nome ao diretorio!"
read diretorio
sudo mkdir /var/$diretorio
echo "diretorio criado"

escolha
}

grupo_novo()
{
echo "criando grupo..."
echo "informe o nome do grupo"
read novo_grupo
groupadd $novo_grupo

escolha
}



usuario_novo()
{
echo "criando usuarios"

echo "qual o nome do usuario?"
read usuario
echo "crie uma senha!"
read senha
echo "informe o grupo!"
read grupo
sudo useradd $usuario -m -s /bin/bash -p $(openssl passwd -crypt $senha) -G $grupo

escolha
}

dono_dir()
{
ls /var
echo "escolha um diretorio"
read diretorio
cat /etc/group
echo "escolha um grupo"
read grupo
sudo chown root:$grupo -R /$diretorio
}

permissao_dir()
{
ls /var
echo "escolha um diretorio"
read diretorio

echo "Selecione uma opção:"
echo "1 - permissão admin e grupo"
echo "2 - publica"
echo "3 - voltar"
read opcao

case $opcao in
"1") sudo chmod 770 /$diretorio;;
"2") sudo chmod 777 /$diretorio;;
"3") escolha;;
esac
}

sair()
{
echo "Até mais!"
exit
}

escolha()
{
echo "Selecione uma opção:"
echo "1 - configurar servidor"
echo "2 - criar novo diretorio"
echo "3 - criar novo grupo"
echo "4 - criar novo usuario"
echo "5 - atribuir grupo a um diretorio"
echo "6 - definir permissoes de um diretorio"
echo "7 - sair"

read opcao;
case $opcao in
"1") servidor;;
"2") novo_diretorio;;
"3") grupo_novo;;
"4") usuario_novo;;
"5") dono_dir;;
"6") permissao_dir;;
"7") sair;;
esac
}
escolha
