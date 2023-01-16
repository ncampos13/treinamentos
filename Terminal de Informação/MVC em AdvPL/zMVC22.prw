//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zMVC22
Função de exemplo para excluir ou recuperar linhas da grid
@type  Function
@author Atilio
@since 29/03/2022
/*/

User Function zMVC22()
    Local aArea  := FWGetArea()
    Local nLinha := 0
    //Pegando os modelos de dados
    Local oModelPad  := FWModelActive()
    Local oModelGrid := oModelPad:GetModel('DA1DETAIL')

    //Percorrendo a grid com os itens
    For nLinha := 1 To oModelGrid:Length()

        //Posicionando na linha atual
        oModelGrid:GoLine(nLinha)
        
        //Se a linha tiver deletada, irá recuperar, senão irá excluir
        If oModelGRID:IsDeleted()
            oModelGRID:UndeleteLine()
        Else
            oModelGRID:DeleteLine()
        EndIf
    Next

    FWRestArea(aArea)
Return
