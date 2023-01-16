//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variveis Estaticas
Static cTitulo := "Artistas"
Static cAliasMVC := "ZD1"

/*/{Protheus.doc} User Function zMVC19
Cadastro de Artistas com componentes adicionados manualmente
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zMVC19()
	Local aArea   := GetArea()
	Local oBrowse
	Private aRotina := {}

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
Menu de opcoes na funcao zMVC19
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
	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zMVC19" OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zMVC19" OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zMVC19" OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zMVC19" OPERATION 5 ACCESS 0
    ADD OPTION aRotina TITLE "Copiar" ACTION "u_zM16Cop" OPERATION 9 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
Modelo de dados na funcao zMVC19
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
	oModel := MPFormModel():New("zMVC19M", bPre, bPos, bCommit, bCancel)
	oModel:AddFields("ZD1MASTER", /*cOwner*/, oStruct)
	oModel:SetDescription("Modelo de dados - " + cTitulo)
	oModel:GetModel("ZD1MASTER"):SetDescription( "Dados de - " + cTitulo)
	oModel:SetPrimaryKey({})
Return oModel

/*/{Protheus.doc} ViewDef
Visualizacao de dados na funcao zMVC19
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function ViewDef()
	Local oModel := FWLoadModel("zMVC19")
	Local oStruct := FWFormStruct(2, cAliasMVC)
	Local oView

	//Cria a visualizacao do cadastro
	oView := FWFormView():New()
	oView:SetModel(oModel)
	
    //Adiciona as seções, sendo a segunda customizada
    oView:AddField("VIEW_ZD1", oStruct, "ZD1MASTER")
    oView:AddOtherObject("VIEW_OTHER", {|oPanel| fCustom(oPanel)})

    //Cria os percentuais dos box
	oView:CreateHorizontalBox("SUPERIOR", 80)
    oView:CreateHorizontalBox("INFERIOR", 20)

    //Vincula os box com as visulizações
	oView:SetOwnerView("VIEW_ZD1",   "SUPERIOR")
    oView:SetOwnerView("VIEW_OTHER", "INFERIOR")

Return oView

Static Function fCustom(oPanel)
	Local aArea   := FWGetArea()
	Local nJanLarg  := oPanel:nWidth
    Local nLinObj := 0
    Local nLargBtn := 60
    //Fontes
    Local cFontPad    := "Tahoma"
    Local oFontBtn    := TFont():New(cFontPad, , -14)
    Local oFontMod    := TFont():New(cFontPad, , -38)
	Local oFontSub    := TFont():New(cFontPad, , -20)
	Local oFontSubN   := TFont():New(cFontPad, , -20, , .T.)
    //Objetos da Janela
    Local oSayModulo, cSayModulo := 'OBS'
    Local oSayTitulo, cSayTitulo := 'Obrigado por ser Assinante Premium'
    Local oSaySubTit, cSaySubTit := 'https://terminaldeinformacao.com'
    Local oSayObs

    //Títulos e SubTítulos
    oSayModulo := TSay():New(004, 003, {|| cSayModulo}, oPanel, "", oFontMod,  , , , .T., RGB(149, 179, 215), , 200, 30, , , , , , .F., , )
    oSayTitulo := TSay():New(004, 045, {|| cSayTitulo}, oPanel, "", oFontSub,  , , , .T., RGB(031, 073, 125), , 200, 30, , , , , , .F., , )
    oSaySubTit := TSay():New(014, 045, {|| cSaySubTit}, oPanel, "", oFontSubN, , , , .T., RGB(031, 073, 125), , 300, 30, , , , , , .F., , )

    //Botões
    oBtnUsu := TButton():New(001, (nJanLarg/2) - (nLargBtn * 3) - 3, "Usuário",     oPanel, {|| FWAlertInfo(UsrRetName(RetCodUsr()), "Usuário Logado")},  nLargBtn,   012, , oFontBtn,  , .T., , , , , , )
    oBtnHor := TButton():New(001, (nJanLarg/2) - (nLargBtn * 2) - 3, "Hora",        oPanel, {|| FWAlertInfo(Time(),                  "Hora Atual")},      nLargBtn,   012, , oFontBtn,  , .T., , , , , , )
    oBtnDat := TButton():New(001, (nJanLarg/2) - (nLargBtn * 1) - 3, "Data",        oPanel, {|| FWAlertInfo(dToC(Date()),            "Data Atual")},      nLargBtn,   012, , oFontBtn,  , .T., , , , , , )

    //Observação
    nLinObj := 028
    oSayObs := TSay():New(nLinObj, 003, {|| "Esse é um exemplo de TSay dentro de um AddOtherObject"}, oPanel, "", oFontBtn, , , , .T., RGB(150, 150, 150), , (nJanLarg/2) - 6, 10, , , , , , .F., , )

	FWRestArea(aArea)
Return
