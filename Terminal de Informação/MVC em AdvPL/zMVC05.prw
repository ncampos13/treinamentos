//Bibliotecas
#Include 'TOTVS.ch'
#Include 'FWMVCDef.ch'
 
/*/{Protheus.doc} zMVC05
MarkBrow em MVC da tabela de Artistas
@author Atilio
@since 11/02/2022
@version 1.0
@obs Criar a coluna ZD1_OK com o tamanho 2 no Configurador e deixar como não usado
/*/
 
User Function zMVC05()
    Private oMark
     
    //Criando o MarkBrow
    oMark := FWMarkBrowse():New()
    oMark:SetAlias('ZD1')
     
    //Setando semáforo, descrição e campo de mark
    oMark:SetSemaphore(.T.)
    oMark:SetDescription('Seleção do Cadastro de Artistas')
    oMark:SetFieldMark('ZD1_OK')
     
    //Ativando a janela
    oMark:Activate()
Return NIL
  
Static Function MenuDef()
    Local aRotina := {}
     
    //Criação das opções
    ADD OPTION aRotina TITLE 'Processar'  ACTION 'u_zMarkProc'    OPERATION 2 ACCESS 0
Return aRotina
 
/*/{Protheus.doc} zMarkProc
Rotina para processamento e verificação de quantos registros estão marcados
@author Atilio
@since 11/02/2022
/*/
 
User Function zMarkProc()
    Local aArea    := GetArea()
    Local cMarca   := oMark:Mark()
    Local nTotal   := 0
     
    //Percorrendo os registros da ZD1
    ZD1->(DbGoTop())
    While ! ZD1->(EoF())
        //Caso esteja marcado, aumenta o contador
        If oMark:IsMark(cMarca)
            nTotal++
             
            //Limpando a marca
            RecLock('ZD1', .F.)
                ZD1_OK := ''
            ZD1->(MsUnlock())
        EndIf
         
        //Pulando registro
        ZD1->(DbSkip())
    EndDo
     
    //Mostrando a mensagem de registros marcados
    MsgInfo('Foram marcados <b>' + cValToChar( nTotal ) + ' artistas</b>.', "Atenção")
     
    //Restaurando área armazenada
    RestArea(aArea)
Return
