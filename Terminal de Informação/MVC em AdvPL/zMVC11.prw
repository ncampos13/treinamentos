//Bibliotecas
#Include 'TOTVS.ch'
#Include 'FWMVCDef.ch'
 
/*/{Protheus.doc} zMVC11
Função para usar o ExecAuto carregando o modelo de dados da tabela
@type function
@author Atilio
@since 28/02/2022
/*/

User Function zMVC11()
	Local aArea     := GetArea()
	Local lDeuCerto := .F.
	Local oModel
	Local oZD1Mod
	Local aErro     := {}

    //Tem que abrir a tabela primeiro, para não ocasionar o erro _SetNamedPrvt : owner private environment not found
    // ao passar pelo GetSXENum
    DbSelectArea("ZD1")

	//Pegando o modelo de dados, setando a operação de inclusão
	oModel := u_z01Model() //FWLoadModel("zMVC01")
	oModel:SetOperation(3)
	oModel:Activate()

	//Pegando o model dos campos
	oZD1Mod:= oModel:getModel("ZD1MASTER")
    oZD1Mod:setValue("ZD1_CODIGO",     GetSXENum("ZD1", "ZD1_CODIGO") )
	oZD1Mod:setValue("ZD1_NOME",       "Chitãozinho e Xororó"         )
	oZD1Mod:setValue("ZD1_OBSERV",     "Observação Teste ExecAuto"    )
    ConfirmSX8()

	//Se conseguir validar as informações e realizar o commit
	If oModel:VldData() .And. oModel:CommitData()
		lDeuCerto := .T.

	//Se não conseguir validar as informações, altera a variável para false
	Else
		lDeuCerto := .F.
	EndIf

	//Se não deu certo a inclusão, mostra a mensagem de erro
	If ! lDeuCerto
		//Busca o Erro do Modelo de Dados
		aErro := oModel:GetErrorMessage()

		//Monta o Texto que será mostrado na tela
		AutoGrLog("Id do formulário de origem:"  + ' [' + AllToChar(aErro[01]) + ']')
		AutoGrLog("Id do campo de origem: "      + ' [' + AllToChar(aErro[02]) + ']')
		AutoGrLog("Id do formulário de erro: "   + ' [' + AllToChar(aErro[03]) + ']')
		AutoGrLog("Id do campo de erro: "        + ' [' + AllToChar(aErro[04]) + ']')
		AutoGrLog("Id do erro: "                 + ' [' + AllToChar(aErro[05]) + ']')
		AutoGrLog("Mensagem do erro: "           + ' [' + AllToChar(aErro[06]) + ']')
		AutoGrLog("Mensagem da solução: "        + ' [' + AllToChar(aErro[07]) + ']')
		AutoGrLog("Valor atribuído: "            + ' [' + AllToChar(aErro[08]) + ']')
		AutoGrLog("Valor anterior: "             + ' [' + AllToChar(aErro[09]) + ']')

		//Mostra a mensagem de Erro
		MostraErro()
	EndIf

	//Desativa o modelo de dados
	oModel:DeActivate()

	RestArea(aArea)
Return
