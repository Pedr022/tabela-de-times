programa {
  inclua biblioteca Tipos --> t
  inclua biblioteca Texto --> txt

  funcao inicio(){
    cadeia nm, pts, gm, gs
    inteiro linha=0, contagem=0
    cadeia menu, nome[15], pontos[15], gols_marcados[15], gols_sofridos[15], saldo_gols[15]
    cadeia tabela[5]={nome, pontos, gols_marcados, gols_sofridos, saldo_gols}
    logico parada=verdadeiro

    enquanto (parada){
      // Criação do menu interativo
      //------------------------------------------------------------------------------------
      escreva("\nSelecione umas das opções abaixo (digite o número correspondente)\n")
      escreva("1. Adicionar time\n")
      escreva("2. Mostrar tabela\n")
      escreva(">>>: ")
      leia(menu)

      // Verifica se atingiu a quantidade máxima de times (15)
      //------------------------------------------------------------------------------------
      se (contagem == 15){
        escreva("Quantidade máxima de times atingida!\n")
        menu = "2"
      }

      // Análise das repostas do menu
      //------------------------------------------------------------------------------------
      se (t.cadeia_e_inteiro(menu, 10)){

        // Adicionar um time a tabela
        //------------------------------------------------------------------------------------
        se (menu == 1){
          escreva("\nNome: ")
          leia(nm)
          escreva("\nQuantidade de pontos: ")
          leia(pts)
          escreva("\nGols marcados: ")
          leia(gm)
          escreva("\nGols sofridos: ")
          leia(gs)

          // Validação de entrada dos valores
          //------------------------------------------------------------------------------------
          se (nao t.cadeia_e_inteiro(pts, 10)){
            escreva("=======================\n")
            escreva("ERRO: Pontos inválidos!\n")
            escreva("=======================\n")
          }
          senao se (nao t.cadeia_e_inteiro(gm, 10) ou nao t.cadeia_e_inteiro(gs, 10)){
            escreva("==============================\n")
            escreva("ERRO: Número de gols inválido!\n")
            escreva("==============================\n")
          }
          senao{
            nome[linha] = nm
            pontos[linha] = pts
            gols_marcados[linha] = gm
            gols_sofridos[linha] = gs

            saldo_gols[linha] = t.inteiro_para_cadeia(t.cadeia_para_inteiro(gols_marcados[linha], 10) - t.cadeia_para_inteiro(gols_sofridos[linha], 10), 10)
            linha++
            contagem++
          }
        }

        // Mostrar tabela
        //------------------------------------------------------------------------------------
        senao se (menu == 2){

          // Verifica se pelo menos um time foi cadastrado
          //------------------------------------------------------------------------------------
          se (contagem == 0){
            escreva("=============================\n")
            escreva("ERRO: Nenhum time cadastrado!\n")
            escreva("=============================\n")
          }

          // Ordenar a tabela por pontos
          //------------------------------------------------------------------------------------
          senao{
            se (contagem > 1){
              inteiro x=1
              faca{
                para (inteiro i=0; i<(contagem-1); i++){
                  se (t.cadeia_para_inteiro(pontos[i], 10) < t.cadeia_para_inteiro(pontos[i+1], 10)){
                    para (inteiro c=0; c<5; c++){
                      cadeia temp[2]
                      temp[0] = tabela[c][i+1]
                      temp[1] = tabela[c][i]
                      tabela[c][i] = temp[0]
                      tabela[c][i+1] = temp[1]
                    }
                  }
                }
                x++
              }enquanto(x < contagem)

              // Desempate por saldo de gols
              //------------------------------------------------------------------------------------
              x=1
              faca{
                para (inteiro i=0; i<(contagem-1); i++){
                  se (pontos[i] == pontos[i+1]){
                    se (t.cadeia_para_inteiro(saldo_gols[i], 10) < t.cadeia_para_inteiro(saldo_gols[i+1], 10)){
                      para (inteiro c=0; c<5; c++){
                        cadeia temp[2]
                        temp[0] = tabela[c][i+1]
                        temp[1] = tabela[c][i]
                        tabela[c][i] = temp[0]
                        tabela[c][i+1] = temp[1]
                      }
                    }
                  }
                }
                x++
              }enquanto(x < contagem)
            }
            
            // Cria a interface da tabela
            //------------------------------------------------------------------------------------
            escreva("\nTabela de classificação:\n")
            escreva(txt.preencher_a_direita("_", 108, ""))
            escreva("\n")

            escreva("  |")
            para (inteiro i=0; i<5; i++){
              cadeia titulo[5] = {"Nome", "Pontos", "Gols marcados", "Gols sofridos", "Saldo de gols"}
              escreva(txt.preencher_a_direita(" ", 20, titulo[i]), "|")
            }
            escreva("\n")
            para (inteiro lin=0; lin<contagem; lin++){
              escreva(lin + 1, ".|")
              para (inteiro col=0; col<5; col++){
                escreva(txt.preencher_a_direita(" ", 20, tabela[col][lin]), "|")
              }
              escreva("\n")
            }
            parada = falso
          }
        }

        // Validação de entrada do menu
        //------------------------------------------------------------------------------------
        senao{
          escreva("==================================\n")
          escreva("ERRO: Escolha uma das duas opções!\n")
          escreva("==================================\n")
        }
      }
      senao{
        escreva("=====================================\n")
        escreva("ERRO: Digite apenas números inteiros!\n")
        escreva("=====================================\n")
      }
    }
  }
}
