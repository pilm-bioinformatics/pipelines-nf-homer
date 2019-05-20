/*
 * Copyright (c) 2013-2019, Centre for Genomic Regulation (CRG).
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * This Source Code Form is "Incompatible With Secondary Licenses", as
 * defined by the Mozilla Public License, v. 2.0.
 *
 */


/*
 * Run Homer finder implemented with Nextflow
 *
 * Authors:
 * - Lorena Pantano <lorena.pantano@gmail.com>
 */


/*
 * Default pipeline parameters. They can be overriden on the command line eg.
 * given `params.foo` specify on the run command line `--foo some_value`.
 */

params.deg = "$baseDir/data/input.txt"
params.outdir = "results"
params.species = "human"
params.start = -400
params.end = 100
params.len = "6,8"
params.bg = "$baseDir/data/bg.txt"
params.install = false

log.info """\
HOMER - N F   P I P E L I N E
 ===================================
 deg        : ${params.deg}
 background : ${params.bg}
 species    : ${params.species}
 outdir     : ${params.outdir}
 """


Channel
    .fromPath(params.deg)
    .map { file -> tuple(file.baseName, file)  }
    .into {deg_ch; deg_info}

deg_info.println()

Channel
    .fromPath(params.bg)
    .set { bg_ch }


process homer {
    tag "$sample"
    publishDir params.outdir, mode: 'copy'

    input:
    set sample, file(deg) from deg_ch
    file(bg) from bg_ch.collect()

    output:
    file(sample) into out_ch
    
    script:
    if (params.install){
      println "Installing indexes."

      """
      BIN=`dirname \$(readlink -f \$(which homer))`
      perl \${BIN}/../configureHomer.pl -install ${params.species}-o  
      perl \${BIN}/../configureHomer.pl -install ${params.species}-p  
      perl \${BIN}/findMotifs.pl ${deg} ${params.species} ${sample} -start ${params.start} \
           -end ${params.end} -len ${params.len} -p ${task.cpus} -bg ${bg} 
      """
    }else{
      """
      BIN=`dirname \$(readlink -f \$(which homer))`
      perl \${BIN}/findMotifs.pl ${deg} ${params.species} ${sample} -start ${params.start} \
           -end ${params.end} -len ${params.len} -p ${task.cpus} -bg ${bg} 
      """
    }
}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone!All results are under --> $params.outdir\n" : "Oops .. something went wrong" )
}
