#!/bin/bash

x="teste"
menu (){
while true $x != "teste"
do
    clear

    echo "-----------------------------------------------------------------------"
    echo ""
    echo -e "\033[01;33m \t\t Bem-vindo ao gerenciador de usuários \t\t \033[01;37m"
    echo ""
    echo "-----------------------------------------------------------------------"
    
    echo ""
    echo "1 - [Criar um novo usuário]"
    echo ""
    echo "2 - [Definir uma senha para um usuário]"
    echo ""
    echo "3 - [Desativar um usuário]"
    echo ""
    echo "4 - [Ativar um usuário]"
    echo ""
    echo "5 - [Adicionar um usuário aos grupo: audio, video, scanner]"
    echo ""
    echo "6 - [Criar um novo grupo]"
    echo ""
    echo "7 - [Adicionar um usuário a um grupo]"
    echo ""
    echo "8 - [Remover um usuário de um grupo]"
    echo ""
    echo "9 - [Forçar usuário a trocar a senha no próximo login]"
    echo ""
    echo "10 - [Forçar usuário a trocar a senha de 30 em 30 dias]"
    echo ""
    echo "11 - [Forçar usuário a trocar a senha no próximo dia]"
    echo ""
    echo "12 - [Nova]"
    echo ""
    echo "13 - [Exit]"
    echo ""
    echo "-----------------------------------------------------------------------"

    echo "Escolha uma opção:"
    read option
    clear
    echo -e "\033[01;33mOpção escolhida: $option \033[01;37m"
    echo "-----------------------------------------------------------------------"

    case "$option" in
    1)
        echo "Digite o nome do novo usuário:"
        read userNome
        useradd $userNome
        echo ""
        echo -e "\033[01;36mVoltando para o menu principal o/\033[01;37m"
        echo ".."
        sleep 1
        echo "."
        sleep 1
    echo "-----------------------------------------------------------------------"
    ;;
    2)
        echo "Digite o nome do usuário que deseja definir uma senha:"
        read userNome
        passwd $userNome
        echo ""
        echo -e "\033[01;36mVoltando para o menu principal o/\033[01;37m"
        echo ".."
        sleep 1
        echo "."
        sleep 1
    echo "-----------------------------------------------------------------------"
    ;;
    3)
        echo "Digite o nome do usuário que deseja desabilitar:"
        read userNome
        usermod -L $userNome
        echo ""
        echo -e "\033[01;36mVoltando para o menu principal o/\033[01;37m"
        echo ".."
        sleep 1
        echo "."
        sleep 1
    echo "-----------------------------------------------------------------------"
    ;;
    4)
        echo "Digite o nome do usuário que deseja habilitar:"
        read userNome
        usermod -U $userNome
        echo ""
        echo -e "\033[01;36mVoltando para o menu principal o/\033[01;37m"
        echo ".."
        sleep 1
        echo "."
        sleep 1
    echo "-----------------------------------------------------------------------"
    ;;
    5)
        echo "Digite o nome do usuário que deseja adicionar nos grupos: audio, video e scanner"
        read userNome
        usermod -G audio,video,scanner $userNome
        echo ""
        echo "-----------------------------------------------------------------------"
        echo "Grupos atuais do usuário"
        echo "-----------------------------------------------------------------------"
        groups $userNome
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal...\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal!\033[01;37m"
        echo ".."
        sleep 1
        echo "."
        sleep 1
    echo "-----------------------------------------------------------------------"
    ;;
     6)
        echo "Digite o nome do grupo que deseja criar"
        read grupo
        echo ""
        #usermod -G <grupo> <usuario> para adidionar novo grupo e manter os outros
        addgroup $grupo
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal...\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal!\033[01;37m"
        echo ".."
        sleep 1
        echo "."
        sleep 1
    echo "-----------------------------------------------------------------------"
    ;;
    7)
        echo "Digite o nome do usuário que deseja inserir a um novo grupo"
        read userNome
        echo ""
        echo "Digite o nome do grupo que deseja inserir o usuário"
        read grupo
        echo ""
        gpasswd -a $userNome $grupo
        echo ""
        echo "-----------------------------------------------------------------------"
        echo "Grupos atuais do usuário"
        echo "-----------------------------------------------------------------------"
        groups $userNome
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal...\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal!\033[01;37m"
        echo ".."
        sleep 1
        echo "."
        sleep 1
    echo "-----------------------------------------------------------------------"
    ;;
    8)
        echo "Digite o nome do usuário que deseja remover de algum grupo"
        read userNome
        echo ""
        echo "Digite o nome do grupo"
        read grupo
        echo ""
        gpasswd -d $userNome $grupo
        echo ""
        echo "-----------------------------------------------------------------------"
        echo "Grupos atuais do usuário"
        echo "-----------------------------------------------------------------------"
        groups $userNome
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal...\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal!\033[01;37m"
        echo ".."
        sleep 1
        echo "."
        sleep 1
    echo "-----------------------------------------------------------------------"
    ;;
    9)
        echo "Digite o nome do usuário para definir expiração de senha no próximo login"
        read userNome
        passwd -e $userNome
        echo ""
        sudo chage -l $userNome
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal...\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal!\033[01;37m"
        echo ".."
        sleep 1
        echo "."
        sleep 1
    echo "-----------------------------------------------------------------------"
    ;;
    10)
        echo "Digite o nome do usuário para definir expiração a cada 30 dias"
        read userNome
        chage -M 30 $userNome
        echo ""
        sudo chage -l $userNome
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal...\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal!\033[01;37m"
        echo ".."
        sleep 1
        echo "."
        sleep 1
    echo "-----------------------------------------------------------------------"
    ;;
    11)
        echo "Digite o nome do usuário para definir expiração para o próximo dia"
        date -d "1 day"
        expiracao=$(date -d "1 day")
        echo $expiracao
        read userNome
        change -M $expiracao $userNome
        echo ""
        sudo chage -l $userNome
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal...\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal!\033[01;37m"
        echo ".."
        sleep 1
        echo "."
        sleep 1
    echo "-----------------------------------------------------------------------"
    ;;
    12)
        echo "Digite o nome do novo usuário:"
        read userNome
        useradd $userNome
        passwd -e $userNome
        chage -M 60 $userNome

        echo "Insira a data de expiração dos usuários (AA-MM-DD)"
        read expiracao
        


        echo -e "\033[01;31m nova\033[01;37m!"
        sleep 5
        clear;
        exit;
    echo "-----------------------------------------------------------------------"
    ;;
    13)
        echo -e "\033[01;31mSaindo...\033[01;37m"
        sleep 2
        clear;
        exit;
    echo "-----------------------------------------------------------------------"
    ;;

    *)
    echo "Opção inválida!"
    esac
done

}
menu