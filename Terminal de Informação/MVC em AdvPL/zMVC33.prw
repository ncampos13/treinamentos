//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variveis Estaticas
Static cTitulo := "Artistas"
Static cAliasMVC := "ZD1"

/*/{Protheus.doc} User Function zMVC33
Cadastro de Artistas com legendas coloridas
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zMVC33()
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

    //Adicionando as Legendas
	oBrowse:AddLegend( "'Í' $ Upper(ZD1->ZD1_NOME)", "BLACK",   "O nome do artista possui o caractere 'Í'")
	oBrowse:AddLegend( "'Õ' $ Upper(ZD1->ZD1_NOME)", "BLUE",    "O nome do artista possui o caractere 'Õ'")
	oBrowse:AddLegend( "'É' $ Upper(ZD1->ZD1_NOME)", "BROWN",   "O nome do artista possui o caractere 'É'")
	oBrowse:AddLegend( "'Ç' $ Upper(ZD1->ZD1_NOME)", "GRAY",    "O nome do artista possui o caractere 'Ç'")
	oBrowse:AddLegend( "'Ó' $ Upper(ZD1->ZD1_NOME)", "GREEN",   "O nome do artista possui o caractere 'Ó'")
	oBrowse:AddLegend( "'Ã' $ Upper(ZD1->ZD1_NOME)", "ORANGE",  "O nome do artista possui o caractere 'Ã'")
	oBrowse:AddLegend( "'U' $ Upper(ZD1->ZD1_NOME)", "PINK",    "O nome do artista possui o caractere 'U'")
	oBrowse:AddLegend( "'O' $ Upper(ZD1->ZD1_NOME)", "RED",     "O nome do artista possui o caractere 'O'")
	oBrowse:AddLegend( "'I' $ Upper(ZD1->ZD1_NOME)", "VIOLET",  "O nome do artista possui o caractere 'I'")
	oBrowse:AddLegend( "'E' $ Upper(ZD1->ZD1_NOME)", "WHITE",   "O nome do artista possui o caractere 'E'")
	oBrowse:AddLegend( "'A' $ Upper(ZD1->ZD1_NOME)", "YELLOW",  "O nome do artista possui o caractere 'A'")

	//Ativa a Browse
	oBrowse:Activate()

	RestArea(aArea)
Return Nil

/*/{Protheus.doc} MenuDef
Menu de opcoes na funcao zMVC33
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
	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zMVC33" OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zMVC33" OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zMVC33" OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zMVC33" OPERATION 5 ACCESS 0
    ADD OPTION aRotina TITLE "Copiar" ACTION "u_zM16Cop" OPERATION 9 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
Modelo de dados na funcao zMVC33
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
	oModel := MPFormModel():New("zMVC33M", bPre, bPos, bCommit, bCancel)
	oModel:AddFields("ZD1MASTER", /*cOwner*/, oStruct)
	oModel:SetDescription("Modelo de dados - " + cTitulo)
	oModel:GetModel("ZD1MASTER"):SetDescription( "Dados de - " + cTitulo)
	oModel:SetPrimaryKey({})
Return oModel

/*/{Protheus.doc} ViewDef
Visualizacao de dados na funcao zMVC33
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function ViewDef()
	Local oModel := FWLoadModel("zMVC33")
	Local oStruct := FWFormStruct(2, cAliasMVC)
	Local oView

	//Cria a visualizacao do cadastro
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_ZD1", oStruct, "ZD1MASTER")
	oView:CreateHorizontalBox("TELA" , 100 )
	oView:SetOwnerView("VIEW_ZD1", "TELA")

Return oView
