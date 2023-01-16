//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zMVC30
Fun��o de exemplo buscar e atualizar valores de campos
@type  Function
@author Atilio
@since 29/03/2022
/*/

User Function zMVC30()
    Local aArea  := FWGetArea()

    //Mostra a pergunta
    If FWAlertYesNo("Deseja utilizar as Fun��es (clique em Sim) ou deseja utilizar os m�todos (clique em N�o)?", "Aten��o")
        fUsaFuncao()
    Else
        fUsaMetodo()
    EndIf

    FWRestArea(aArea)
Return

Static Function fUsaFuncao()
    Local aPergs    := {}
    Local cDescri   := FWFldGet("DA0_DESCRI")
    
    //Adicionando os parametros que ser�o digitados
    aAdd(aPergs, {1, "Descri��o",  cDescri,  "",     "NaoVazio()", "", ".T.", 80,  .T.})
    
    If ParamBox(aPergs, "Informe os par�metros", , , , , , , , , .F., .F.)
        //Atualiza o valor
        cDescri := MV_PAR01
        FwFldPut("DA0_DESCRI", cDescri)
    EndIf
Return

Static Function fUsaMetodo()
    Local aPergs    := {}
    Local oModelPad := FWModelActive()
    Local cDescri   := oModelPad:GetValue("DA0MASTER", "DA0_DESCRI")
    
    //Adicionando os parametros que ser�o digitados
    aAdd(aPergs, {1, "Descri��o",  cDescri,  "",     "NaoVazio()", "", ".T.", 80,  .T.})
    
    If ParamBox(aPergs, "Informe os par�metros", , , , , , , , , .F., .F.)
        //Atualiza o valor
        cDescri := MV_PAR01
        oModelPad:SetValue("DA0MASTER", "DA0_DESCRI", cDescri)
    EndIf
Return
