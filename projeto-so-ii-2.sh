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
    echo "3 - [Desativar contas criadas a 30 dias e que nunca foram usadas]"
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

        echo "Digite a quantidade de usuários temporários que deseja criar"
        read quant_usuario_temp
        echo ""

        if test $quant_usuario_perm -gt 0
        then
            echo -e "\033[01;33mCentral de criação de usuários permanentes\033[01;37m"
            echo "-----------------------------------------------------------------------"
            echo "Digite o nome padão dos usuários permanentes"
            read nome_usuario_perm
            sleep 5
            echo ""

            for count in $(seq 1 $quant_usuario_perm); do
                usuario_definido=$nome_usuario_perm$count

                echo -e "\033[01;32mCriando usuário: [$usuario_definido]...\033[01;37m"
                sleep 1

                useradd $usuario_definido -p $(openssl passwd -1 $usuario_definido)
                id $usuario_definido
                egrep [1][0-9]{3} /etc/passwd | cut -d: -f1
                echo ""

                echo -e "\033[01;32mConfigurando senha do usuário: [$usuario_definido]...\033[01;37m"
                sleep 1
                
                passwd --expire $usuario_definido
                chage -M 60 $usuario_definido
                chage -l $usuario_definido
                echo ""

                echo -e "\033[01;32mConfigurando expiração de conta do usuário: [$usuario_definido]...\033[01;37m"
                sleep 1
                chage -l $usuario_definido

                echo ""

                echo -e "\033[01;36mUsuario $usuario_definido finalizado.\033[01;37m"

                echo "-----------------------------------------------------------------------"
                echo ""
            done
        fi

        if test $quant_usuario_temp -gt 0
        then
            echo -e "\033[01;33mCentral de criação de usuários temporários\033[01;37m"
            echo "-----------------------------------------------------------------------"
            echo "Digite o nome padão dos usuários temporários"
            read nome_usuario_temp
            sleep 5
            echo ""

            for count in $(seq 1 $quant_usuario_temp); do
                usuario_definido=$nome_usuario_temp$count

                echo -e "\033[01;32mCriando usuário: [$usuario_definido]...\033[01;37m"

                useradd $usuario_definido -p $(openssl passwd -1 $usuario_definido)
                id $usuario_definido
                # egrep [1][0-9]{3} /etc/passwd | cut -d: -f1
                sleep 1
                echo ""

                echo -e "\033[01;32mConfigurando senha do usuário: [$usuario_definido]...\033[01;37m"
                
                passwd --expire $usuario_definido
                chage -M 60 $usuario_definido
                chage -W 15 $usuario_definido
                echo ""
                chage -l $usuario_definido
                sleep 1
                echo ""

                echo -e "\033[01;32mConfigurando expiração de conta do usuário: [$usuario_definido]...\033[01;37m"
                # echo "Defina a data de expiração das contas temporário no seguinte formato: AAAA/MM/DD. "
                # hoje=$(date +%Y/%m/%d)
                # read expira
                expira=2025/02/02
                echo -e "\033[01;36mConfirudando data de expiração para $expira...\033[01;37m"
                chage -E $expira $usuario_definido
                echo ""
                chage -l $usuario_definido
                sleep 1

                echo -e "\033[01;32mConfigurando diretório do usuário: [$usuario_definido]...\033[01;37m"
                echo -e "\033[01;36mCriando diretório home...\033[01;37m"
                mkdir /home/$usuario_definido
                chown $usuario_definido:$usuario_definido /home/$usuario_definido
                sleep 1

                echo -e "\033[01;36mCriando diretório /etc/temp_skel/...\033[01;37m"
                #config do skel
                mkdir /etc/temp_skel
                cp -av /etc/skel/ /etc/temp_skel
                # cp -av /etc/skel/\.[a-zA-Z]* /etc/temp_skel
                #--------------------------------------------
                sleep 1

                echo -e "\033[01;36mCopiando arquivos /etc/temp_skel/ para pasta /home/$usuario_definido...\033[01;37m"
                #config do skel
                cp -av /etc/temp_skel/ /home/$usuario_definido
                # cp -av /etc/temp_skel/\.[a-zA-Z]* /home/$usuario_definido
                sleep 1

                # chown -R $usuario_definido /home/$usuario_definido
                # sudo grep -E '/home/$nome_usuario' /etc/passwd
                # useradd -k /etc/temp_skel

                echo -e "\033[01;32mConfigurando grupos do usuário: [$usuario_definido]...\033[01;37m"
                echo -e "\033[01;36mDefinindo grupo primário..\033[01;37m"
                usermod -g users $usuario_definido

                echo -e "\033[01;36mDefinindo grupos secundários..\033[01;37m"
                usermod -aG audio,video $usuario_definido
                groups $usuario_definido

                echo ""
                echo -e "\033[01;32mUsuario $usuario_definido finalizado!\033[01;37m"

                echo "-----------------------------------------------------------------------"
                echo ""
            done
        fi

        echo -e "\033[01;33mDigite qualquer tecla para voltar para o menu principal!\033[01;37m"
        read
        echo -e "\033[01;36mVoltando para o menu principal...\033[01;37m"
        sleep 1

    echo "-----------------------------------------------------------------------"
    ;;
    2)
        echo "Digite o nome do usuário que deseja definir uma senha:"
        hoje=$(date +%Y/%m/%d)
        echo $hoje
        echo $(date +%Y/%m/%d)
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
