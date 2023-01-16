//Bibliotecas
#Include 'TOTVS.ch'
#Include 'FWMVCDef.ch'
 
/*/{Protheus.doc} zMVC10
Função de teste que demonstra o funcionamento da FWExecView (abertura de outra view)
@type function
@author Atilio
@since 28/02/2022
/*/

User Function zMVC10()
    Local aArea   := GetArea()
    Local cFunBkp := FunName()
     
    DbSelectArea('SA2')
    SA2->(DbSetOrder(1)) //Filial + Código + Loja
     
    //Se conseguir posicionar
    If SA2->(DbSeek(FWxFilial('SA2') + "F00002"))
        SetFunName("MATA020")
        FWExecView('Visualizacao Teste', 'MATA020', MODEL_OPERATION_VIEW)
        SetFunName(cFunBkp)
    EndIf
     
    RestArea(aArea)
Return
