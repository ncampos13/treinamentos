//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variveis Estaticas
Static cTitulo := "Artistas"
Static cAliasMVC := "ZD1"

/*/{Protheus.doc} User Function zMVC20
Cadastro de Artistas com gatilhos criados via código
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zMVC20()
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
Menu de opcoes na funcao zMVC20
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
	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zMVC20" OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zMVC20" OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zMVC20" OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zMVC20" OPERATION 5 ACCESS 0
    ADD OPTION aRotina TITLE "Copiar" ACTION "u_zM16Cop" OPERATION 9 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
Modelo de dados na funcao zMVC20
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
    Local aGatilhos := {}
    Local nAtual    := 0

    //Adicionando um gatilho, do BM_GRUPO para o BM_DESC
    aAdd(aGatilhos, ;
        FWStruTriggger(;
            "ZD1_NOME",;                                //Campo Origem
            "ZD1_OBSERV",;                              //Campo Destino
            "u_z20Gat()",;             //Regra de Preenchimento
            .F.,;                                       //Irá Posicionar?
            "",;                                        //Alias de Posicionamento
            0,;                                         //Índice de Posicionamento
            '',;                                        //Chave de Posicionamento
            NIL,;                                       //Condição para execução do gatilho
            "01";                                       //Sequência do gatilho
        );
    )
 
    //Percorrendo os gatilhos e adicionando na Struct
    For nAtual := 1 To Len(aGatilhos)
        oStruct:AddTrigger(;
            aGatilhos[nAtual][01],; //Campo Origem
            aGatilhos[nAtual][02],; //Campo Destino
            aGatilhos[nAtual][03],; //Bloco de código na validação da execução do gatilho
            aGatilhos[nAtual][04];  //Bloco de código de execução do gatilho
        )
    Next


	//Cria o modelo de dados para cadastro
	oModel := MPFormModel():New("zMVC20M", bPre, bPos, bCommit, bCancel)
	oModel:AddFields("ZD1MASTER", /*cOwner*/, oStruct)
	oModel:SetDescription("Modelo de dados - " + cTitulo)
	oModel:GetModel("ZD1MASTER"):SetDescription( "Dados de - " + cTitulo)
	oModel:SetPrimaryKey({})
Return oModel

/*/{Protheus.doc} ViewDef
Visualizacao de dados na funcao zMVC20
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function ViewDef()
	Local oModel := FWLoadModel("zMVC20")
	Local oStruct := FWFormStruct(2, cAliasMVC)
	Local oView

	//Cria a visualizacao do cadastro
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_ZD1", oStruct, "ZD1MASTER")
	oView:CreateHorizontalBox("TELA" , 100 )
	oView:SetOwnerView("VIEW_ZD1", "TELA")

Return oView

/*/{Protheus.doc} User Function z20Gat
Gatilho disparado do campo nome para o campo observação
@type  Function
@author Atilio
@since 29/03/2022
@return cRetorno, Caractere, Retorno que será preenchido no campo de observação
/*/

User Function z20Gat()
    Local aArea    := FWGetArea()
    Local cRetorno := ""

    //Preenche o retorno do campo
    cRetorno := dToC(Date()) + " as " + Time() + ", " + SubStr(FwFldGet("ZD1_NOME"), 1, 3)

    FWRestArea(aArea)
Return cRetorno
