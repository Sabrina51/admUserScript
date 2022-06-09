#!/bin/bash

x="teste"
menu (){
while true $x != "teste"
do
    clear

    echo "-----------------------------------------------------------------------"
    echo ""
    echo -e "\e[1;33m \t\t Bem-vindo ao gerenciador de contas \t\t \e[0m"
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
    echo -e "\e[33mOpção escolhida: $option \e[0m"
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
            echo -e "\e[33mCentral de criação de usuário(s) permanente(s)\e[0m"
            echo "-----------------------------------------------------------------------"
            echo "Digite o nome padão do(s) usuário(s) permanente(s)"
            read nome_usuario_perm
            sleep 5
            echo ""

            for count in $(seq 1 $quant_usuario_perm); do
                usuario_definido_perm=$nome_usuario_perm$count

                echo -e "\e[1;32mCriando usuário: [$usuario_definido_perm]\e[0m"
                useradd -m -k /etc/skel $usuario_definido_perm -p $(openssl passwd -1 $usuario_definido_perm)

                id $usuario_definido_perm
                # egrep [1][0-9]{3} /etc/passwd | cut -d: -f1
                sleep 1
                echo ""

                echo -e "\e[1;32mConfigurando senha do usuário: [$usuario_definido_perm]\e[0m"
                passwd --expire $usuario_definido_perm
                chage -M 60 $usuario_definido_perm
                echo ""
                chage -l $usuario_definido_perm
                sleep 1
                echo ""

                echo -e "\e[1;32mConfigurando diretório do usuário: [$usuario_definido_perm]\e[0m"
                echo -e "\e[36mDefinindo permições...\e[0m"
                sudo chmod 700 -R /home/$usuario_definido_perm
                sleep 1
                echo ""

                echo -e "\e[1;32mConfigurando grupos do usuário: [$usuario_definido_perm]\e[0m"
                echo -e "\e[36mDefinindo grupos secundários..\e[0m"
                sudo usermod -aG audio,video,storage,scanner,users $usuario_definido_perm
                if [ $? -gt 0 ]
                then
                    addgroup storage
                    addgroup users
                    usermod -aG audio,video,storage,scanner,users $usuario_definido_perm
                fi
                echo ""
                echo -e "\e[36mGrupos atuais do usuário:\e[0m"
                groups $usuario_definido_perm

                echo ""
                echo ""
                echo -e "Usuario \e[1;32m[$usuario_definido_perm]\e[0m finalizado!"

                echo "-----------------------------------------------------------------------"
                echo ""
            done
            echo -e "\e[35mCriação do(s) usuário(s) permanente(s) concluida!\e[0m"
            echo "Aperte qualquer tecla para continuar..."
            read
        fi

        if test $quant_usuario_temp -gt 0
        then
            echo -e "\e[33mCentral de criação de usuário(s) temporário(s)\e[0m"
            echo "-----------------------------------------------------------------------"
            echo "Digite o nome padão do(s) usuário(s) temporário(s)"
            read nome_usuario_temp
            sleep 5
            echo ""

            for count in $(seq 1 $quant_usuario_temp); do
                usuario_definido=$nome_usuario_temp$count

                echo -e "\e[1;32mCriando usuário: [$usuario_definido]\e[0m"
                echo -e "\e[36mDefinindo skel...\e[0m"

                mkdir /etc/temp_skel
                if [ $? -eq 0 ]
                then
                    cp -av /etc/skel/\.[a-zA-Z]* /etc/temp_skel
                else 
                    echo "Seguindo..."
                fi
                echo ""

                echo -e "\e[36mDefinido nome, diretório e senha...\e[0m"
                useradd -m -k /etc/temp_skel $usuario_definido -p $(openssl passwd -1 $usuario_definido)
                id $usuario_definido
                sleep 1
                echo ""
                
                echo -e "\e[1;32mConfigurando senha do usuário: [$usuario_definido]\e[0m"
                echo -e "\e[36mDefinido parâmetros para próxima troca de senha...\e[0m"
                chage -M 60 $usuario_definido

                echo -e "\e[36mDefinido parâmetros para aviso de troca de senha...\e[0m"
                chage -W 15 $usuario_definido

                echo -e "\e[36mDefinido parâmetros para expiração de senha...\e[0m"
                passwd --expire $usuario_definido
                echo ""
                # echo "Defina a data de expiração das contas temporário no seguinte formato: AAAA/MM/DD. "
                # hoje=$(date +%Y/%m/%d)
                # read expira
                expira=2025/02/02
                echo -e "\e[36mDefinido data de expiração de conta do usuário...\e[0m"
                echo -e "Data definida para expiração de conta: \e[31m$expira\e[0m"
                chage -E $expira $usuario_definido

                echo ""
                chage -l $usuario_definido

                sleep 1
                echo ""

                echo -e "\e[1;32mConfigurando diretório do usuário: [$usuario_definido]\e[0m"
                echo -e "\e[36mDefinindo permições...\e[0m"
                sudo chmod 700 -R /home/$usuario_definido
                sleep 1
                echo ""

                echo -e "\e[1;32mConfigurando grupos do usuário: [$usuario_definido]\e[0m"
                echo -e "\e[36mDefinindo grupo primário..\e[0m"
                usermod -g users $usuario_definido
                if [ $? -gt 0 ]
                then
                    addgroup users
                    usermod -g users $usuario_definido
                fi
                echo -e "\e[36mDefinindo grupos secundários..\e[0m"
                usermod -aG audio,video $usuario_definido
                echo ""
                echo -e "\e[36mGrupos atuais do usuário:\e[0m"
                groups $usuario_definido

                echo ""
                echo ""
                echo -e "Usuario \e[1;32m[$usuario_definido]\e[0m finalizado!"

                echo "-----------------------------------------------------------------------"
                echo ""
            done
            echo -e "\e[35mCriação do(s) usuário(s) temporário(s) concluida!\e[0m"
            echo "Aperte qualquer tecla para continuar..."
            read
        fi

        echo -e "\e[33mDigite qualquer tecla para voltar para o menu principal!\e[0m"
        read
        sleep 1

    echo "-----------------------------------------------------------------------"
    ;;
    2)
        echo -e "\e[33mDesativando contas com mais de 120 dias sem uso\e[0m"
        last -t '-120 days' | awk -F" " '{ print $1}' | sort | uniq | grep -v begins | xargs -I@ chage -l @

        echo -e "\e[35mLimpeza concluida!\e[0m"
        echo ""
        echo -e "\e[33mDigite qualquer tecla para voltar para o menu principal!\e[0m"
        read
        sleep 1
    echo "-----------------------------------------------------------------------"
    ;;
    3)
         echo -e "\e[33mDesativando contas com mais de 120 dias sem uso\e[0m"
        last -t '-120 days' | awk -F" " '{ print $1}' | sort | uniq | grep -v begins | xargs -I@ chage -l @
        lastlog | grep 'nunca logou' | sort | uniq | awq -F: '{ print $7}' /etc/passwd | grep "/bin/sh" | sort | uniq | xargs -I@ chage -l @

        echo -e "\e[35mLimpeza concluida!\e[0m"
        echo ""
        echo -e "\e[33mDigite qualquer tecla para voltar para o menu principal!\e[0m"
        read
        sleep 1
    echo "-----------------------------------------------------------------------"
    ;;
    4)
        echo ""
        echo -e "\e[1;31mSaindo...\e[0m"
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
