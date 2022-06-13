#!/bin/bash

x="teste"
menu (){
while true $x != "teste"
do
    clear

    echo "-----------------------------------------------------------------------"
    echo ""
    echo -e "\e[1;33m \t\t Bem-vindo ao gerenciador de usuários \t\t \e[0m"
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
    echo "6 - [Adicionar um usuário a um ou mais grupos]"
    echo ""
    echo "7 - [Remover um usuário de um grupo]"
    echo ""
    echo "8 - [Forçar usuário a trocar a senha no próximo login]"
    echo ""
    echo "9 - [Forçar usuário a trocar a senha de 30 em 30 dias]"
    echo ""
    echo "10 - [Definir expiração data para expiração de conta]"
    echo ""
    echo "11 - [Criar usuários com políticas espefíficas]"
    echo ""
    echo "12 - [Exit]"
    echo ""
    echo "-----------------------------------------------------------------------"

    echo "Escolha uma opção:"
    read option
    clear
    echo -e "\e[33mOpção escolhida: $option \e[0m"
    echo "-----------------------------------------------------------------------"

    case "$option" in
    1)
        echo "Digite o nome do novo usuário:"
        read nome_usuario
        echo ""
        echo -e "\e[32mCriando usuário\e[0m"
        useradd $nome_usuario
        id $nome_usuario
        echo ""

        echo -e "\e[32mConfigurando diretório do usuário\e[0m"
        echo -e "\e[36mCriando diretório /home/default...\e[0m"
        mkdir /home/default
        chown $nome_usuario:$nome_usuario /home/default
        echo ""

        echo -e "\e[32mConfigurando grupo do usuário\e[0m"
        usermod -g users $nome_usuario
        if [ $? -gt 0 ]
        then
            addgroup users
            usermod -g users $nome_usuario
        fi
        groups $nome_usuario
        echo ""
        echo -e "\e[33mDigite qualquer tecla para voltar para o menu principal!\e[0m"
        read
        echo -e "\e[36mVoltando para o menu principal...\e[0m"
    echo "-----------------------------------------------------------------------"
    ;;
    2)
        echo "Digite o nome do usuário que deseja definir uma senha:"
        read nome_usuario
        passwd $nome_usuario
        echo ""
        echo -e "\e[33mDigite qualquer tecla para voltar para o menu principal!\e[0m"
        read
        echo -e "\e[36mVoltando para o menu principal...\e[0m"
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
        echo -e "\e[33mDigite qualquer tecla para voltar para o menu principal!\e[0m"
        read
        echo -e "\e[36mVoltando para o menu principal...\e[0m"
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
        echo -e "\e[33mDigite qualquer tecla para voltar para o menu principal!\e[0m"
        read
        echo -e "\e[36mVoltando para o menu principal...\e[0m"
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
        echo -e "\e[33mDigite qualquer tecla para voltar para o menu principal!\e[0m"
        read
        echo -e "\e[36mVoltando para o menu principal...\e[0m"
    echo "-----------------------------------------------------------------------"
    ;;
    6)
        echo "Digite o nome do usuário que deseja inserir a um novo grupo"
        read nome_usuario
        echo ""
        echo "Digite o nome do grupo que deseja inserir o usuário"
        read nome_grupo
        echo ""

        usermod -aG $nome_grupo $nome_usuario
        if [ $? -gt 0 ]
        then
            addgroup $nome_grupo
            usermod -aG $nome_grupo $nome_usuario
        fi
        # gpasswd -a $nome_usuario $grupo
        echo ""
        echo "-----------------------------------------------------------------------"
        echo "Grupos atuais do usuário"
        echo "-----------------------------------------------------------------------"
        groups $nome_usuario
        echo ""
        echo -e "\e[33mDigite qualquer tecla para voltar para o menu principal!\e[0m"
        read
        echo -e "\e[36mVoltando para o menu principal...\e[0m"
    echo "-----------------------------------------------------------------------"
    ;;
    7)
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
        echo -e "\e[33mDigite qualquer tecla para voltar para o menu principal!\e[0m"
        read
        echo -e "\e[36mVoltando para o menu principal...\e[0m"
    echo "-----------------------------------------------------------------------"
    ;;
    8)
        echo "Digite o nome do usuário para definir expiração de senha no próximo login"
        read nome_usuario
        passwd --expire $nome_usuario
        echo ""
        chage -l $nome_usuario
        echo ""
        echo -e "\e[33mDigite qualquer tecla para voltar para o menu principal!\e[0m"
        read
        echo -e "\e[36mVoltando para o menu principal...\e[0m"
    echo "-----------------------------------------------------------------------"
    ;;
    9)
        echo "Digite o nome do usuário para definir expiração a cada 30 dias"
        read nome_usuario
        chage -M 30 $nome_usuario
        echo ""
        chage -l $nome_usuario
        echo ""
        echo -e "\e[33mDigite qualquer tecla para voltar para o menu principal!\e[0m"
        read
        echo -e "\e[36mVoltando para o menu principal...\e[0m"
    echo "-----------------------------------------------------------------------"
    ;;
    10)
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
        echo -e "Data definida para expiração de conta: \e[31m$expira\e[0m"
        echo ""
        chage -l $nome_usuario
        echo ""
        echo -e "\e[33mDigite qualquer tecla para voltar para o menu principal!\e[0m"
        read
        echo -e "\e[36mVoltando para o menu principal...\e[0m"
    echo "-----------------------------------------------------------------------"
    ;;
    11)
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
            sleep 1
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
            sleep 2
       fi

        if test $quant_usuario_temp -gt 0
        then
            echo -e "\e[33mCentral de criação de usuário(s) temporário(s)\e[0m"
            echo "-----------------------------------------------------------------------"
            echo "Digite o nome padão do(s) usuário(s) temporário(s)"
            read nome_usuario_temp
            sleep 1
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
            sleep 2
        fi

        echo -e "\e[33mDigite qualquer tecla para voltar para o menu principal!\e[0m"
        read
        sleep 1

    echo "-----------------------------------------------------------------------"
    ;;
    12)
        echo -e "\e[31mSaindo...\e[0m"
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