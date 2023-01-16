/* ===
    Esse o um exemplo disponibilizado no Terminal de Informacao
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2018/02/13/funcao-para-executar-formulas-protheus-12/
    Caso queira ver outros conteodos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zMiniForm
Funcao Mini Formulas, para executar formulas
@author Atilio
@since 17/12/2017
@version 1.0
@type function
@obs Assim como o formulas foi bloqueado no Protheus 12, cuidado ao deixar exposto no menu o Mini Formulas
/*/

User Function zMiniForm()
	Local aArea := GetArea()
	//Varioveis da tela
	Private oDlgForm
	Private oGrpForm
	Private oGetForm
	Private cGetForm := Space(250)
	Private oGrpAco
	Private oBtnExec
	//Tamanho da Janela
	Private nJanLarg := 500
	Private nJanAltu := 120
	Private nJanMeio := ((nJanLarg)/2)/2
	Private nTamBtn  := 048
	
	//Criando a janela
	DEFINE MSDIALOG oDlgForm TITLE "zMiniForm - Execucao de Formulas" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
		//Grupo Formula com o Get
		@ 003, 003  GROUP oGrpForm TO 30, (nJanLarg/2)-1        PROMPT "Formula: " OF oDlgForm COLOR 0, 16777215 PIXEL
			@ 010, 006  MSGET oGetForm VAR cGetForm SIZE (nJanLarg/2)-9, 013 OF oDlgForm COLORS 0, 16777215 PIXEL
		
		//Grupo Acaes com o Botoo
		@ (nJanAltu/2)-30, 003 GROUP oGrpAco TO (nJanAltu/2)-3, (nJanLarg/2)-1 PROMPT "Acaes: " OF oDlgForm COLOR 0, 16777215 PIXEL
			@ (nJanAltu/2)-24, nJanMeio - (nTamBtn/2) BUTTON oBtnExec PROMPT "Executar" SIZE nTamBtn, 018 OF oDlgForm ACTION(fExecuta()) PIXEL
		
	//Ativando a janela
	ACTIVATE MSDIALOG oDlgForm CENTERED
	
	RestArea(aArea)
Return

/*---------------------------------------*
 | Func.: fExecuta                       |
 | Desc.: Executa a formula digitada     |
 *---------------------------------------*/

Static Function fExecuta()
	Local aArea    := GetArea()
	Local cFormula := Alltrim(cGetForm)
	Local cError   := ""
	Local bError   := ErrorBlock({ |oError| cError := oError:Description})
	
	//Se tiver conteodo digitado
	If ! Empty(cFormula)
		//Inicio a utilizacao da tentativa
		Begin Sequence
			&(cFormula)
		End Sequence
		
		//Restaurando bloco de erro do sistema
		ErrorBlock(bError)
		
		//Se houve erro, sero mostrado ao usuorio
		If ! Empty(cError)
			MsgStop("Houve um erro na formula digitada: "+CRLF+CRLF+cError, "Atencao")
		EndIf
	EndIf
	
	RestArea(aArea)
Return
