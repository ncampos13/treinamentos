//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variveis Estaticas
Static cTitulo := "Artistas"
Static cAliasMVC := "ZD1"

/*/{Protheus.doc} User Function zMVC16
Cadastro de Artistas (com cópia)
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zMVC16()
	Local aArea   := GetArea()
	Local oBrowse
	Private aRotina := {}
    Private l16Copia := .F. //Flag criada caso seja necessário validações internas

	//Definicao do menu
	aRotina := MenuDef()

	//Instanciando o browse
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias(cAliasMVC)
	oBrowse:SetDescription(cTitulo)
	oBrowse:DisableDetails()

	//Ativa a Browse
	oBrowse:Activate()

	RestArea(aArea)
Return Nil

/*/{Protheus.doc} MenuDef
Menu de opcoes na funcao zMVC16
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function MenuDef()
	Local aRotina := {}

	//Adicionando opcoes do menu
	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zMVC16" OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zMVC16" OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zMVC16" OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zMVC16" OPERATION 5 ACCESS 0
    ADD OPTION aRotina TITLE "Copiar" ACTION "u_zM16Cop" OPERATION 9 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
Modelo de dados na funcao zMVC16
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function ModelDef()
	Local oStruct := FWFormStruct(1, cAliasMVC)
	Local oModel
	Local bPre := Nil
	Local bPos := Nil
	Local bCommit := Nil
	Local bCancel := Nil


	//Cria o modelo de dados para cadastro
	oModel := MPFormModel():New("zMVC16M", bPre, bPos, bCommit, bCancel)
	oModel:AddFields("ZD1MASTER", /*cOwner*/, oStruct)
	oModel:SetDescription("Modelo de dados - " + cTitulo)
	oModel:GetModel("ZD1MASTER"):SetDescription( "Dados de - " + cTitulo)
	oModel:SetPrimaryKey({})
Return oModel

/*/{Protheus.doc} ViewDef
Visualizacao de dados na funcao zMVC16
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function ViewDef()
	Local oModel := FWLoadModel("zMVC16")
	Local oStruct := FWFormStruct(2, cAliasMVC)
	Local oView

	//Cria a visualizacao do cadastro
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_ZD1", oStruct, "ZD1MASTER")
	oView:CreateHorizontalBox("TELA" , 100 )
	oView:SetOwnerView("VIEW_ZD1", "TELA")

Return oView

/*/{Protheus.doc} User Function zM16Cop
Função que realiza a abertura da tela com campos alterados (cópia)
@type  Function
@author Atilio
@since 29/03/2022
/*/

User Function zM16Cop()
    Local aArea        := FWGetArea()
    Local cTitulo      := "Cópia"
    Local cPrograma    := "zMVC16"
    Local nOperation   := MODEL_OPERATION_INSERT
     
    //Caso precise testar em algum lugar
    l16Copia     := .T.
     
    //Carrega o modelo de dados
    oModel := FWLoadModel(cPrograma)
    oModel:SetOperation(nOperation) // Inclusão
    oModel:Activate(.T.) // Ativa o modelo com os dados posicionados
     
    //Pegando o campo de chave
    cNovoCod := GetSXENum("ZD1", "ZD1_CODIGO")
    ConfirmSX8()
     
    //Setando os campos do cabeçalho
    oModel:SetValue("ZD1MASTER", "ZD1_CODIGO",  cNovoCod)
    oModel:SetValue("ZD1MASTER", "ZD1_OBSERV",  "Cópia do código - " + ZD1->ZD1_CODIGO)
    oModel:SetValue("ZD1MASTER", "ZD1_DTFORM",  Date())
     
    //Executando a visualização dos dados para manipulação
    nRet     := FWExecView(cTitulo , cPrograma, nOperation, /*oDlg*/, {|| .T. } ,/*bOk*/ , /*nPercReducao*/, /*aEnableButtons*/, /*bCancel*/ , /*cOperatId*/, /*cToolBar*/, oModel)
    l16Copia := .F.
    oModel:DeActivate()
     
    //Se a cópia for confirmada
    If nRet == 0
        /* Deu tudo certo */
    EndIf
     
    FWRestArea(aArea)
Return
