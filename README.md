# hse21_H3K4me3_G4_human

## Отчет по работе над проектом
## выполнила студентка 3 гр. Ищенко Анна

#### Начало работы

С помощью команды `wget` были получены два файла с данными в формате `.bed`: 

`wget https://www.encodeproject.org/files/ENCFF546BXF/@@download/ENCFF546BXF.bed.gz`

`wget https://www.encodeproject.org/files/ENCFF388IXL/@@download/ENCFF388IXL.bed.gz`

Далее для работы были оставлены только первые 5 столбцов в каждом из файлов (*а также файлы были переименованы*)

`zcat ENCFF388IXL.bed.gz | cut -f1-5 > H3K3me3_DND-41_ENCFF388IXL.hg38.bed.hg38.bed`

`zcat ENCFF546BXF.bed.gz | cut -f1-5 > H3K3me3_DND-41_ENCFF546BXF.hg38.bed.hg38.bed`

(в названии меток возникли опечатки - далее по ходу работы они будут исправлены - однако на протяжении всей работы имеется в виду метка **H3K4me3**)

При помощи команды `liftOver` было произведено преобразование координат из версии сборки генома **hg38** в **hg19**:

`liftOver   H3K3me3_DND-41_ENCFF388IXL.hg38.bed   hg38ToHg19.over.chain.gz   H3K3me3_DND-41_ENCFF388IXL.hg19.bed  H3K3me3_DND-41_ENCFF388IXL.unmapped.bed`

`liftOver   H3K3me3_DND-41_ENCFF546BXF.hg38.bed   hg38ToHg19.over.chain.gz   H3K3me3_DND-41_ENCFF546BXF.hg19.bed  H3K3me3_DND-41_ENCFF546BXF.unmapped.bed`

#### Распределение длин участков

Строим гистограммы распределения длин участков для каждого эксперимента до и после конвертации к нужной версии генома с помощью [скрипта](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/src/s1.R).
Гистограмма для [ENCFF546BXF.hg38](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/Results/len_hist.XF.hg38.bedno_filter.pdf), 
для [ENCFF546BXF.hg19](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/Results/len_hist.XF.hg19.bedno_filter.pdf), 
для [ENCFF546BXL.hg38](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/Results/len_hist.XL.hg38.bedno_filter.pdf) и
для [ENCFF546BXL.hg19](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/Results/len_hist.XL.hg19.bedno_filter.pdf).

Теперь отфильтруем слишком длинные участки (>50000) с помощью [скрипта](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/src/s3.R), снова построим гистограммы распределения длин и посмотрим, что изменилось: 
для [ENCFF546BXF.hg38](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/Results/len_hist.XF.hg38.bed.filtered.pdf), 
для [ENCFF546BXF.hg19](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/Results/len_hist.XF.hg19.bed.filtered.pdf), 
для [ENCFF546BXL.hg38](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/Results/len_hist.XL.hg38.bed.filtered.pdf) и 
для [ENCFF546BXL.hg19](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/Results/len_hist.XL.hg19.bed.filtered.pdf).

Сильных изменений не наблюдается. Для дальнейшей работы будем использовать отфильтрованные файлы версии **hg19**.

С использованием геномного браузера можно посмотреть, куда попадают участки из экспериментов:

`track visibility=dense name="ENCFF388IXL"  description="H3K4me3_DND-41_ENCFF388IXL.hg19.filtered.bed"
https://raw.githubusercontent.com/student1832/hse21_H3K4me3_G4_human/main/data/XL.hg19.filtered.bed`

`track visibility=dense name="ENCFF546BXF"  description="H3K4me3_DND-41_ENCFF546BXF.hg19.filtered.bed"
https://raw.githubusercontent.com/student1832/hse21_H3K4me3_G4_human/main/data/XF.hg19.filtered.bed`.

#### Аннотация генов

С использованием библиотеки *ChIPseeker* при помощи [скрипта](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/src/s4.R) строим круговые диаграммы аннотации для данных экспериментов:
[ENCFF546BXF](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/Results/XF.hg19.plotAnnoPie.png) и 
[ENCFF546BXL](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/Results/XL.hg19.plotAnnoPie.png). В первом случае интронов больше всего, а промоторы и экзоны занимают примерно равные небольшие доли. Во втором случае промоторов почти столько же, сколько интронов, но экзонов все еще мало.
Этот же скрипт позволяет получить распределения по хромосомам для [ENCFF546BXF](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/Results/resultschip_seeker.XF.hg19.covplot.pdf) и [ENCFF546BXL](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/Results/resultschip_seeker.XL.hg19.covplot.pdf).

Объединяем два набора отфильтрованных ChIP-seq пиков с помощью утилиты `bedtools merge` (результат [здесь](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/data/H3K4me3_DND.merge.hg19.bed)), после чего снова визуализируем данные в геномном браузере.

#### Анализ участков вторичной структуры ДНК

Скачиваем два файла со вторичной структурой ДНК и объединяем их в один с помощью утилиты `bedtools merge` (результат [здесь](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/data/G4_seq_Li_KH3K4.bed)).
Строим [распределение длин участков вторичной стр-ры ДНК](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/Results/len_hist.G4.png) с помощью [этого](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/src/s1.R) скрипта (71254 пика) и смотрим, где [располагаются участки стр-ры ДНК относительно аннотированных генов](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/Results/chip_seeker.G4.plotAnnoPie.png) с помощью [этого](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/src/s4.R) скрипта.

#### Анализ пересечений гистоновой метки и стр-ры ДНК

Находим пересечения гистоновой меткой и стр-рами ДНК:

`bedtools intersect  -a  G4_seq_Li_KH3K4.bed   -b  H3K4me3_DND.merge.hg19.bed  >  H3K4me3_DND.intersect_with_G4.bed`

[Визуализируем](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/Results/gb_vis.png) в геномном браузере исходные участки стр-ры ДНК, а также их пересечения с гистоновой меткой (вся сессия сохранена [здесь](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/data/DND_with_G4)).

Ассоциируем полученные пересечения с ближайшими генами с использованием библиотеки *ChIPpeakAnno* при помощи [скрипта](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/src/s5.R) и получаем [файл ассоциаций пиков с генами](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/data/H3K4me3_DND.intersect_with_G4.genes.txt) (1623), а также [список уникальных генов](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/data/H3K4me3_DND.intersect_with_G4.genes_uniq.txt) (1327).

Далее проведем GO-анализ для полученных уникальных генов. Для этого воспользуемся сайтом http://pantherdb.org/.
Наиболее значимыми оказались regulation of multicellular organismal process (FDR = 2.59E-14), positive regulation of metabolic process	(FDR = 5.22E-14), 
positive regulation of macromolecule metabolic process (FDR = 6.71E-14), positive regulation of cellular metabolic process (FDR = 9.41E-14). Полный результат сохранен [здесь](https://github.com/student1832/hse21_H3K4me3_G4_human/blob/main/data/pantherdb_GO_analysis.txt).


