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
    echo "7 - [Adicionar um usuário a um ou mais grupos]"
    echo ""
    echo "8 - [Remover um usuário de um grupo]"
    echo ""
    echo "9 - [Forçar usuário a trocar a senha no próximo login]"
    echo ""
    echo "10 - [Forçar usuário a trocar a senha de 30 em 30 dias]"
    echo ""
    echo "11 - [Definir expiração data para expiração de conta]"
    echo ""
    echo "12 - [Exit]"
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
        read nome_usuario
        useradd $nome_usuario
        echo ""
        id $nome_usuario
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal!\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal...\033[01;37m"
    echo "-----------------------------------------------------------------------"
    ;;
    2)
        echo "Digite o nome do usuário que deseja definir uma senha:"
        read nome_usuario
        passwd $nome_usuario
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal!\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal...\033[01;37m"
    echo "-----------------------------------------------------------------------"
    ;;
    3)
        echo "Digite o nome do usuário que deseja desabilitar:"
        read nome_usuario
        usermod -L $nome_usuario
        echo ""
        echo "-----------------------------------------------------------------------"
        echo "Usuários ativos no sistema:"
        echo "-----------------------------------------------------------------------"
        passwd -S -a|awk '$2 ~ /P/ {print $q}'
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal!\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal...\033[01;37m"
    echo "-----------------------------------------------------------------------"
    ;;
    4)
        echo "Digite o nome do usuário que deseja habilitar:"
        read nome_usuario
        usermod -U $nome_usuario
        echo ""
        echo "-----------------------------------------------------------------------"
        echo "Usuários ativos no sistema:"
        echo "-----------------------------------------------------------------------"
        passwd -S -a|awk '$2 ~ /P/ {print $q}'
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal!\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal...\033[01;37m"
    echo "-----------------------------------------------------------------------"
    ;;
    5)
        echo "Digite o nome do usuário que deseja adicionar nos grupos: audio,"
        echo "video e scanner."
        read nome_usuario
        usermod -G audio,video,scanner $nome_usuario
        echo ""
        echo "-----------------------------------------------------------------------"
        echo "Grupos atuais do usuário"
        echo "-----------------------------------------------------------------------"
        groups $nome_usuario
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal!\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal...\033[01;37m"
    echo "-----------------------------------------------------------------------"
    ;;
    6)
        echo "Digite o nome do grupo que deseja criar"
        read nome_grupo
        echo ""
        addgroup $nome_grupo
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal!\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal...\033[01;37m"
    echo "-----------------------------------------------------------------------"
    ;;
    7)
        echo "Digite o nome do usuário que deseja inserir a um novo grupo"
        read nome_usuario
        echo ""
        echo "Digite o nome do grupo ou dos grupos que deseja inserir o usuário"
        echo "(ex: grupo ou grupo1,grupo2)"
        read nome_grupo
        echo ""
        usermod -G $nome_grupo $nome_usuario
        # gpasswd -a $nome_usuario $grupo
        echo ""
        echo "-----------------------------------------------------------------------"
        echo "Grupos atuais do usuário"
        echo "-----------------------------------------------------------------------"
        groups $nome_usuario
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal!\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal...\033[01;37m"
    echo "-----------------------------------------------------------------------"
    ;;
    8)
        echo "Digite o nome do usuário que deseja remover de algum grupo"
        read nome_usuario
        echo ""
        echo "Digite o nome do grupo"
        read nome_grupo
        echo ""
        gpasswd -d $nome_usuario $nome_grupo
        echo ""
        echo "-----------------------------------------------------------------------"
        echo "Grupos atuais do usuário"
        echo "-----------------------------------------------------------------------"
        groups $nome_usuario
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal!\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal...\033[01;37m"
    echo "-----------------------------------------------------------------------"
    ;;
    9)
        echo "Digite o nome do usuário para definir expiração de senha no próximo login"
        read nome_usuario
        passwd --expire $nome_usuario
        echo ""
        chage -l $nome_usuario
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal!\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal...\033[01;37m"
    echo "-----------------------------------------------------------------------"
    ;;
    10)
        echo "Digite o nome do usuário para definir expiração a cada 30 dias"
        read nome_usuario
        chage -M 30 $nome_usuario
        echo ""
        chage -l $nome_usuario
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal!\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal...\033[01;37m"
    echo "-----------------------------------------------------------------------"
    ;;
    11)
        echo "Digite o nome do usuário que deseja definir data de expiração da conta."
        read nome_usuario
        echo ""
        #configura com a entrada do usuario
        # echo "Digite a data de expiração no seguinte formato: AAAA/MM/DD."
        # read expira
        #--------------------------------------------------------------------
        #configura para o dia de amanha a expiracao
        expira=$(date -d "+1 days" '+%Y/%m/%d')
        chage -E $expira $nome_usuario
        echo -e "Data definida para expiração de conta: \033[01;31m$expira\033[01;37m"
        echo ""
        chage -l $nome_usuario
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal!\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal...\033[01;37m"
    echo "-----------------------------------------------------------------------"
    ;;
    12)
        echo ""
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