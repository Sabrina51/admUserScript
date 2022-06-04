#!/bin/bash

x="teste"
menu (){
while true $x != "teste"
do
    clear

    echo "-----------------------------------------------------------------------"
    echo ""
    echo -e "\033[01;33m \t\t Bem-vindo ao gerenciador de contas \t\t \033[01;37m"
    echo ""
    echo "-----------------------------------------------------------------------"
    
    echo ""
    echo "1 - [Criar usuários com políticas espefíficas]"
    echo ""
    echo "2 - [Configuração de expiração de contas]"
    echo ""
    echo "3 - [Desativar contas com 30 dias e nunca foi usada]"
    echo ""
    echo "4 - [Exit]"
    echo ""
    echo "-----------------------------------------------------------------------"

    echo "Escolha uma opção:"
    read option
    clear
    echo -e "\033[01;33mOpção escolhida: $option \033[01;37m"
    echo "-----------------------------------------------------------------------"

    case "$option" in
    1)
        echo "Digite a quantidade de usuários permanentes que deseja criar"
        read quant_usuario_perm
        echo ""
        echo "Digite o nome padão dos usuários permanentes"
        read nome_usuario_perm
        echo ""
        # echo "Digite a quantidade de usuários temporários que deseja criar"
        # read quant_usuario_temp
        # echo ""
        # echo "Digite o nome padão dos usuários temporários"
        # read nome_usuario_temp
        # echo ""

        for count in $(seq 1 $quant_usuario_perm); do
            usuario_definido=$nome_usuario_perm$count
            echo -e "\033[01;32mCriando usuário: [$usuario_definido]...\033[01;37m"
            sleep 1
            useradd $usuario_definido -p $(openssl passwd -1 $usuario_definido)
            id $usuario_definido
            echo ""

            echo -e "\033[01;32mConfigurando senha do usuário: [$usuario_definido]...\033[01;37m"
            sleep 1
            passwd --expire $usuario_definido
            chage -M 60 $usuario_definido
            chage -l $usuario_definido
            echo ""

            echo -e "\033[01;32mConfigurando expiração de conta do usuário: [$usuario_definido]...\033[01;37m"
            sleep 1

            echo ""

            echo -e "\033[01;36mUsuario $usuario_definido finalizado.\033[01;37m"

            echo "-----------------------------------------------------------------------"
            echo ""
        done
    echo "-----------------------------------------------------------------------"
    ;;
    2)
        echo "Digite o nome do usuário que deseja definir uma senha:"
        read userNome
        passwd $userNome
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal!\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal...\033[01;37m"
        sleep 1
    echo "-----------------------------------------------------------------------"
    ;;
    3)
        echo "Digite o nome do usuário que deseja definir uma senha:"
        read userNome
        passwd $userNome
        echo ""
        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal!\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal...\033[01;37m"
        sleep 1
    echo "-----------------------------------------------------------------------"
    ;;

    *)
    echo "Opção inválida!"
    esac
done
}
menu