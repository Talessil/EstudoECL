IMPORT Matriculas;
file := Matriculas.File_Matricula;

//********************************************************************************************************************************//
//****************************************************** ESTATÍSTICAS INICIAIS ***************************************************//
//********************************************************************************************************************************//
//***************************** Os resultados de cada consulta estão comentados da frente de cada 'output' ***********************//
//********************************************************************************************************************************//
//********************************************************************************************************************************//

//--------------------------------------------------------------------------------------------------------------------------------//
//-------------------------------------------------------- ANÁLISE DOS ALUNOS ----------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------------------------//
// -Quantidade de matrículas distintas.                                                                                           //
// -Quantidade de alunos de cada sexo.                                                                                            //
// -Quantidade de alunos de cada cor/raça                                                                                         //
// -Quantidade de alunos que nasceram em outro estado (fora de SP).                                                               //
// -Quantidade de alunos que possuem alguma deficiência.                                                                          //
// -Quantidade de alunos que possuem mais de uma deficiência.                                                                     //
// -Situação dos alunos (Aprovado, Reprovado, Situação não Definida)                                                              //
//                                                                                                                                //
//--------------------------------------------------------------------------------------------------------------------------------//

		/* ----------------------------------------- */
		/* QUANTIDADE DE MATRÍCULAS NA BASE DE DADOS */
		/* ----------------------------------------- */
fileCount := COUNT(file);
output('Número Total de Matrículas: ' + fileCount); //--result: 1756527


		/* ---------------------------------------------------- */
		/* QUANTIDADE DE ALUNOS DO SEXO 'MASCULINO' E 'FEMININO */
		/* ---------------------------------------------------- */
isMasc := file.cd_sexo = 'M';
isFem := file.cd_sexo = 'F';
mascCount := COUNT(file(isMasc));
femCount := COUNT(file(isFem));
output('Número de Alunos do Sexo Masculino: ' + mascCount); //--result: 879232
output('Número de Alunos do Sexo Feminino: ' + femCount); //--result: 877295


		/* ------------------------------------- */
		/* QUANTIDADE DE ALUNOS DE CADA COR/RACA */ 
		/* ------------------------------------- */
countBranca := COUNT(file(file.cd_raca_cor = 1));
countPreta := COUNT(file(file.cd_raca_cor = 2));
countParda := COUNT(file(file.cd_raca_cor = 3));
countAmarela := COUNT(file(file.cd_raca_cor = 4 OR file.cd_raca_cor = 6)); //*na base de dados está amarelo como 4 e 6
countIndigena := COUNT(file(file.cd_raca_cor = 5));

output('cor e raca - Branca: ' + countBranca 
	+ ' Preta: ' + countPreta 
	+ ' Parda: ' + countParda 
	+ ' Amarela: ' + countAmarela 
	+ ' Indigena: ' + countIndigena); //--result: Branca: 573167 
																	 //          Preta: 61640 
																	 //          Parda: 458341 
																	 //          Amarela: 603606 
																	 //          Indigena: 3271


		/* ------------------------------------------------------------ */
		/*QUANTIDADE DE ALUNOS QUE NASCERAM EM OUTRO ESTADO (FORA DE SP)*/
		/* ------------------------------------------------------------ */
isNasceuOutroEstado := file.desc_uf_nasc != 'SP';
nasceuOutroEstadosCount := COUNT(file(isNasceuOutroEstado));
output('Número de Alunos que Nasceram em outros Estados (fora de SP): ' + nasceuOutroEstadosCount); //--result: 170901


	/* --------------------------------------------------- */
	/* QUANTIDADE DE ALUNOS QUE POSSUEM ALGUMA DEFICIÊNCIA */
	/* --------------------------------------------------- */
isDef := file.def_autismo = 1 
			OR file.def_surdez_leve = 1 
			OR file.def_surdez_sev = 1 
			OR file.def_intelect = 1
			OR file.def_multipla = 1
			OR file.def_cegueira = 1
			OR file.def_baixa_visao = 1
			OR file.def_surdo_ceg = 1
			OR file.def_transt_des_inf = 1
			OR file.def_sindr_asper = 1
			OR file.def_sindr_rett = 1
			OR file.def_fis_n_cadeir = 1
			OR file.def_fis_cadeir = 1;
		
defCount := COUNT(file(isDef));
output('Número de Indivíduos com pelo Menos Uma Deficiência: ' + defCount); //--result: 43888
defPerc := (defCount * 100)/fileCount;
output('% doS Indivíduos com pelo Menos Uma Deficiência: ' + defPerc); //--result: 2.498566774094563 %


	/* -------------------------------------------------------- */
	/* QUANTIDADE DE ALUNOS QUE POSSUEM MAIS DE UMA DEFICIÊNCIA */
	/* -------------------------------------------------------- */
isVariasDeficiencias := file.def_autismo 
			+ file.def_surdez_leve 
			+ file.def_surdez_sev
			+ file.def_intelect
			+ file.def_multipla
			+ file.def_cegueira
			+ file.def_baixa_visao
			+ file.def_surdo_ceg
			+ file.def_transt_des_inf
			+ file.def_sindr_asper
			+ file.def_sindr_rett
			+ file.def_fis_n_cadeir
			+ file.def_fis_cadeir >= 2;

variasDeficienciasCount := COUNT(file(isVariasDeficiencias));
output('Número de Alunos que Possuem Mais de Uma Deficiência: ' + variasDeficienciasCount);	//--result: 5324


		/* ------------------- */
		/* SITUAÇÃO DOS ALUNOS */
		/* ------------------- */
sumSituacaoAprov := sum(file, file.sit_al_aprov);
//Alunos em Situcao de Aprovado
output('Alunos em Situcao de Aprovado: ' + sumSituacaoAprov); //--result: 455043
//Percentual (%) de alunos aprovados
aveSituacaoAprov := ave(file, file.sit_al_aprov);
output('Percentual (%) de alunos aprovados: ' +  aveSituacaoAprov*100); //--result: 25.90583577707601 %

//Alunos em Situacao de Reprovado
sumSituacaoReprov := sum(file, file.sit_al_reprov);
output('Alunos em Situacao de Reprovado: ' + sumSituacaoReprov); //--result: 37288
//Percentual (%) de Alunos em Situcao de Reprovado
aveSituacaoReprov := ave(file, file.sit_al_reprov);
output('Percentual (%) de Alunos em Situcao de Reprovado: ' + aveSituacaoReprov*100); //--result: 2.122825325201377 %

//Alunos que Não Possuem Situação Definida
SituacaoNaoDefinida := fileCount - (sumSituacaoAprov + sumSituacaoReprov);
output('Quantidade Alunos que Não Possuem Situcao Definida: ' + SituacaoNaoDefinida); //--result: 1264196
//Percentual (%) de Alunos que Não Possuem Situação Definida
PerSituacaoNaoDefinida := 100 - (100*aveSituacaoAprov + 100*aveSituacaoReprov);
output('Percentual (%) de Alunos que Não Possuem Situcao Definida: ' + PerSituacaoNaoDefinida); //--result: 71.9713388977226 %


//--------------------------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------  ANÁLISE DAS ESCOLAS --------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------------------------//
// -Quantidade de escolas em cada situação: Ativa, Extinta ou Paralisada.                                                         //
// -Quantidade de escolas de cada etapa: educação infantil, eja cieja, etc...                                                     //
// -Percentual (%) de alunos que possuem aula no fds, e a Quantidade de escolas que também possuem aulas no fds.                  //
// -Quantidade de Matrículas em cada Distrito.                                                                                    //
// -Distrito(s) com Mais e com Menos Escolas.                                                                                     //
//                                                                                                                                // 
//--------------------------------------------------------------------------------------------------------------------------------//

		/* ------------------------------------------------------------------- */
		/* QUANTIDADE DE ESCOLAS EM SITUAÇÃO 'ATIVA', 'EXTINTA' E 'PARALISADA' */
		/* ------------------------------------------------------------------- */
isAtiva := file.situacao_escola = 'ATIVA';
isExtinta := file.situacao_escola = 'EXTINTA';
isParalisada := file.situacao_escola = 'PARALISADA';
countAtiva := COUNT(file(isAtiva));
countExtinta := COUNT(file(isExtinta));
countParalisada := COUNT(file(isParalisada)); 
output('Número de Escolas Ativas: ' + countAtiva); //--result: 1747884
output('Número de Escolas Extintas: ' + countExtinta); //--result: 8643
output('Número de Escolas Paralisada: ' + countParalisada); //--result: 0


		/* ----------------------------------- */
		/* QUANTIDADE DE ESCOLAS DE CADA ETAPA */
		/* ----------------------------------- */
isEducacaoInfantil := file.desc_etapa_ensino = 'EDUCACAO INFANTIL';
isEjaCieja := file.desc_etapa_ensino = 'EJA CIEJA';
isEjaEscolasEducacaoEspecial := file.desc_etapa_ensino = 'EJA ESCOLAS EDUCACAO ESPECIAL';
isEjaEscolasEnsinoFundamental := file.desc_etapa_ensino = 'EJA ESCOLAS ENSINO FUNDAMENTAL';
isEnsinoFundamental9Anos := file.desc_etapa_ensino = 'ENSINO FUNDAMENTAL DE 9 ANOS';
isEnsinoMedio := file.desc_etapa_ensino = 'ENSINO MEDIO';
isEnsinoMedioNormalMagisterio := file.desc_etapa_ensino = 'ENSINO MEDIO NORMAL/MAGISTERIO';
isProjevem := file.desc_etapa_ensino = 'PROJOVEM';
isTecnicoMedio := file.desc_etapa_ensino = 'TECNICO MEDIO';
countEducacaoInfantil := COUNT(file(isEducacaoInfantil));
countEjaCieja := COUNT(file(isEjaCieja));
countEjaEscolasEducacaoEspecial := COUNT(file(isEjaEscolasEducacaoEspecial));
countEjaEscolasEnsinoFundamental := COUNT(file(isEjaEscolasEnsinoFundamental));
countEnsinoFundamental9Anos := COUNT(file(isEnsinoFundamental9Anos));
countEnsinoMedio := COUNT(file(isEnsinoMedio));
countEnsinoMedioNormalMagisterio := COUNT(file(isEnsinoMedioNormalMagisterio));
countProjevem := COUNT(file(isProjevem));
countTecnicoMedio := COUNT(file(isTecnicoMedio));
output('Número de Etapa de Ensino - Educação Infantil: ' + countEducacaoInfantil); //--result: 732855
output('Número de Etapa de Ensino - Eja Cieja: ' + countEjaCieja); //--result: 21720
output('Número de Etapa de Ensino - Eja Escolas Educação Especial: ' + countEjaEscolasEducacaoEspecial); //--result: 46
output('Número de Etapa de Ensino - Eja Escolas Ensino Fundamental: ' + countEjaEscolasEnsinoFundamental); //--result: 96088
output('Número de Etapa de Ensino - Ensino Fundamental de 9 Anos: ' + countEnsinoFundamental9Anos); //--result: 513366
output('Número de Etapa de Ensino - Ensino Médio: ' + countEnsinoMedio); //--result: 3234
output('Número de Etapa de Ensino - Ensino Médio Normal Magisterio: ' + countEnsinoMedioNormalMagisterio); //--result: 186
output('Número de Etapa de Ensino - Projoven: ' + countProjevem); //--result: 0
output('Número de Etapa de Ensino - Técnico Médio: ' + countTecnicoMedio); //--result: 4158


	/* --------------------------------------------------------------------------- */
	/* Percentual (%) DE ALUNOS, E A QUANTIDADE DE ESCOLAS QUE POSSUEM AULA NO FDS */
	/* --------------------------------------------------------------------------- */
isFds := file.SAB = 1
			OR file.DOM = 1;
			
FdsCount := COUNT(file(isFds));
FdsPerc := (FdsCount * 100)/fileCount;
output('% de Alunos que Tem Aula no FDS: ' + FdsPerc); //--result: 0.3548479471138218 %(menos de 1%)
alunosFsd := file(isFds);
TAB_distinct_escola := TABLE(alunosFsd,{nome_escola},nome_escola);
output('Quantidade de Escolas distintas que tem Aula no Fds: ' + count(TAB_distinct_escola)); //--result: 49

		/* ----------------------------------------- */
		/* QUANTIDADE DE MATRÍCULAS EM CADA DISTRITO */
		/* ----------------------------------------- */
layout_matricula_by_distrito := RECORD
	file.nome_distrito;
	countDistrito := COUNT(GROUP);
END;
XTAB_matricula_por_distrito := TABLE(file,layout_matricula_by_distrito,file.nome_distrito); 
output(XTAB_matricula_por_distrito);

		/* ---------------------------------------- */
		/* DISTRITO(S) COM MAIS E COM MENOS ESCOLAS */
		/* ---------------------------------------- */
XTAB_escola_distrito := TABLE(file,{nome_distrito,nome_escola},nome_distrito,nome_escola); 
//quantidade de escolas distintas por distrito
XTAB_escola_distinta_distrito := TABLE(XTAB_escola_distrito,{nome_distrito,COUNT(GROUP)},nome_distrito); 
output(XTAB_escola_distinta_distrito(XTAB_escola_distinta_distrito._unnamed_cnt_2 = MAX(XTAB_escola_distinta_distrito, XTAB_escola_distinta_distrito._unnamed_cnt_2)));
output(XTAB_escola_distinta_distrito(XTAB_escola_distinta_distrito._unnamed_cnt_2 = MIN(XTAB_escola_distinta_distrito, XTAB_escola_distinta_distrito._unnamed_cnt_2))); 
																	//--result:
																	//          distrito(s) com mais escolas distintas: BRASILANDIA       	151
																	//          distrito(s) com menos escolas distintas: JARDIM PAULISTA   	2
																	//                                                   MARSILAC          	2
																	//                                                   REPUBLICA         	2


