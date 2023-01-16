//Bibliotecas
#Include 'TOTVS.ch'
#Include 'FWMVCDef.ch'
 
/*/{Protheus.doc} zMVC05
MarkBrow em MVC da tabela de Artistas
@author Atilio
@since 11/02/2022
@version 1.0
@obs Criar a coluna ZD1_OK com o tamanho 2 no Configurador e deixar como n�o usado
/*/
 
User Function zMVC05()
    Private oMark
     
    //Criando o MarkBrow
    oMark := FWMarkBrowse():New()
    oMark:SetAlias('ZD1')
     
    //Setando sem�foro, descri��o e campo de mark
    oMark:SetSemaphore(.T.)
    oMark:SetDescription('Sele��o do Cadastro de Artistas')
    oMark:SetFieldMark('ZD1_OK')
     
    //Ativando a janela
    oMark:Activate()
Return NIL
  
Static Function MenuDef()
    Local aRotina := {}
     
    //Cria��o das op��es
    ADD OPTION aRotina TITLE 'Processar'  ACTION 'u_zMarkProc'    OPERATION 2 ACCESS 0
Return aRotina
 
/*/{Protheus.doc} zMarkProc
Rotina para processamento e verifica��o de quantos registros est�o marcados
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
    MsgInfo('Foram marcados <b>' + cValToChar( nTotal ) + ' artistas</b>.', "Aten��o")
     
    //Restaurando �rea armazenada
    RestArea(aArea)
Return
