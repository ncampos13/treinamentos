//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zMVC25
Função de exemplo para posicionar em uma linha da grid
@type  Function
@author Atilio
@since 29/03/2022
/*/

User Function zMVC25()
    Local aArea  := FWGetArea()
    Local aPergs   := {}
    Local nLinha   := 1
    Local nTamanho := 0
    //Pegando os modelos de dados
    Local oModelPad  := FWModelActive()
    Local oModelGrid := oModelPad:GetModel('DA1DETAIL')
    
    //Adicionando os parametros que serão digitados
    nTamanho := oModelGrid:Length()
    aAdd(aPergs, {1, "Em qual linha quer posicionar",  nLinha,  "@E 999",     "Positivo() .And. (&(ReadVar()) <= " + cValToChar(nTamanho) + ")", "", ".T.", 80,  .T.})
    
    If ParamBox(aPergs, "Informe os parâmetros", , , , , , , , , .F., .F.)
        //Posicionando na linha digitada
        nLinha := MV_PAR01
        oModelGrid:GoLine(nLinha)
    EndIf

    FWRestArea(aArea)
Return
