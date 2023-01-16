//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zMVC30
Função de exemplo buscar e atualizar valores de campos
@type  Function
@author Atilio
@since 29/03/2022
/*/

User Function zMVC30()
    Local aArea  := FWGetArea()

    //Mostra a pergunta
    If FWAlertYesNo("Deseja utilizar as Funções (clique em Sim) ou deseja utilizar os métodos (clique em Não)?", "Atenção")
        fUsaFuncao()
    Else
        fUsaMetodo()
    EndIf

    FWRestArea(aArea)
Return

Static Function fUsaFuncao()
    Local aPergs    := {}
    Local cDescri   := FWFldGet("DA0_DESCRI")
    
    //Adicionando os parametros que serão digitados
    aAdd(aPergs, {1, "Descrição",  cDescri,  "",     "NaoVazio()", "", ".T.", 80,  .T.})
    
    If ParamBox(aPergs, "Informe os parâmetros", , , , , , , , , .F., .F.)
        //Atualiza o valor
        cDescri := MV_PAR01
        FwFldPut("DA0_DESCRI", cDescri)
    EndIf
Return

Static Function fUsaMetodo()
    Local aPergs    := {}
    Local oModelPad := FWModelActive()
    Local cDescri   := oModelPad:GetValue("DA0MASTER", "DA0_DESCRI")
    
    //Adicionando os parametros que serão digitados
    aAdd(aPergs, {1, "Descrição",  cDescri,  "",     "NaoVazio()", "", ".T.", 80,  .T.})
    
    If ParamBox(aPergs, "Informe os parâmetros", , , , , , , , , .F., .F.)
        //Atualiza o valor
        cDescri := MV_PAR01
        oModelPad:SetValue("DA0MASTER", "DA0_DESCRI", cDescri)
    EndIf
Return
