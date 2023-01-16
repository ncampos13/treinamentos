//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function OMSA010
Cadastro de Tabelas de Preço
@author Daniel Atilio
@since 28/02/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
     *-------------------------------------------------*
     Por se tratar de um p.e. em MVC, salve o nome do 
     arquivo diferente, por exemplo, OMSA010_pe.prw 
     *-----------------------------------------------*
     A documentacao de como fazer o p.e. esta disponivel em https://tdn.totvs.com/pages/releaseview.action?pageId=208345968 

     Associe "FORM" com banco de dados, com ModelDef
     Associe "MODEL" com visualização, com ViewDef
@see http://autumncodemaker.com
/*/

User Function OMSA010()
	Local aArea := FWGetArea()
	Local aParam := PARAMIXB 
	Local xRet := .T.
	Local oObj := Nil
	Local cIdPonto := ""
	Local cIdModel := ""
    Local nLinha := 0
	
	//Se tiver parametros
	If aParam != Nil
		
		//Pega informacoes dos parametros
		oObj := aParam[1]
		cIdPonto := aParam[2]
		cIdModel := aParam[3]
			
		//Antes da alteracao de qualquer campo do formulario 
		If cIdPonto == "FORMPRE" 
			xRet := .T. 

            nOper   := oObj:GetModel(cIdPonto):nOperation
			cTipo   := aParam[4]
			cObjeto := aParam[5]

			//Se for Alteração
			If nOper == 4
				//Não permite alteração de alguns campos da DA0
				If Type("cTipo") == "C" .And. cTipo == "ISENABLE" .And. Alltrim(cObjeto) == "DA0MASTER"
					xRet := .F.
				EndIf
			EndIf
			
		//Na validacao total do modelo (ao clicar no confirmar)
		ElseIf cIdPonto == "MODELPOS" 
			xRet := .T. 

            //Define as variáveis que serão usadas
			aAreaDA1 := DA1->(FWGetArea())
			dData    := Date()
			cUsrNom  := PadR(UsrRetName(RetCodUsr()), 30)

			//Pegando os modelos de dados
			oModelPad  := FWModelActive()
			oModelGrid := oModelPad:GetModel('DA1DETAIL')
			cCodTab    := oModelPad:GetValue("DA0MASTER", "DA0_CODTAB")

			DbSelectArea("DA1")
			DA1->(DbSetOrder(3)) //DA1_FILIAL + DA1_CODTAB + DA1_ITEM
			
			//Percorrendo a grid com os itens
			For nLinha := 1 To oModelGrid:Length()
				lGravaAlt := .F.

				//Posicionando na linha atual
				oModelGrid:GoLine(nLinha)
				
				//Se a linha tiver deletada, irá armazenar a data e o usuário de alteração
				If oModelGRID:IsDeleted()
					lGravaAlt := .T.

				//Senão, se não for inserção
				ElseIf ! oModelGRID:IsInserted()
					
					//Posiciona na tabela DA1
					DA1->(DbSeek(FWxFilial('DA1') + cCodTab + oModelGrid:GetValue("DA1_ITEM") ))

                    //Se o preço tiver sido alterado
                    If DA1->DA1_PRCVEN != oModelGrid:GetValue("DA1_PRCVEN")
                        lGravaAlt := .T.
                    EndIf
				EndIf

				If lGravaAlt
					oModelGrid:SetValue("DA1_X_ADAT", dData)
					oModelGrid:SetValue("DA1_X_AUSR", cUsrNom)
				EndIf
			Next

			FWRestArea(aAreaDA1)
			
		//Apos a gravacao total do modelo e fora da transacao 
		ElseIf cIdPonto == "MODELCOMMITNTTS" 
            nOper := oObj:nOperation

			//Se for inclusão, mostra mensagem de sucesso
			If nOper == 3
				Aviso('Atenção', 'Registro criado com sucesso - ' + DA0->DA0_CODTAB, {'OK'}, 03)
			EndIf
			
		//Para a inclusao de botoes na ControlBar 
		ElseIf cIdPonto == "BUTTONBAR" 
			xRet := {} 

            aAdd(xRet, {"* Titulo 1", "", {|| Alert("Botão 1")}, "Tooltip 1"})
			aAdd(xRet, {"* Titulo 2", "", {|| Alert("Botão 2")}, "Tooltip 2"})
			aAdd(xRet, {"* Titulo 3", "", {|| Alert("Botão 3")}, "Tooltip 3"})

			aAdd(xRet, {"* Adicionar Linha",            "", {|| u_zMVC18()}, "Adic. Linha"})
			aAdd(xRet, {"* Limpar Grid",                "", {|| u_zMVC21()}, "Limp. Grid"})
			aAdd(xRet, {"* Deletar / Recuperar Linhas", "", {|| u_zMVC22()}, "Del. Rec. Linhas"})
			aAdd(xRet, {"* Salvar e Voltar a Posição",  "", {|| u_zMVC24()}, "Salv. Volt. Pos."})
			aAdd(xRet, {"* Ir para Linha",              "", {|| u_zMVC25()}, "Ir Linha"})
			aAdd(xRet, {"* Tamanho da Grid",            "", {|| u_zMVC26()}, "Tam. Grid"})
			aAdd(xRet, {"* Atualizar Descrição",        "", {|| u_zMVC30()}, "Atu. Descr"})
			
		EndIf
		
	EndIf
	
	FWRestArea(aArea)
Return xRet
