--select t1.* 
--update compras_produto set VALOR_ORIGINAL=(t1.custo1 * t1.qtde_original), VALOR_ENTREGAR=(t1.custo1 * t1.qtde_entregar)
update compras set TOT_QTDE_ORIGINAL=qtde_original, TOT_QTDE_ENTREGAR=qtde_entregar
from COMPRAS  
inner join 
(
select pedido, max(custo1) as custo1, sum(QTDE_ORIGINAL) as qtde_original, sum(qtde_entregar) as qtde_entregar
from compras_produto a
where a.PEDIDO in
('258433V'
,'258438V'
,'264379V'
,'264380V'
,'264381V'
,'264382V'
,'264383V'
,'264384V'
,'265664V'
,'263559V'
,'263564V'
,'263576V'
,'264216V'
,'264218V'
,'264219V'
,'264220V'
,'264221V'
,'264222V'
,'264223V'
,'264224V'
,'264225V'
,'264226V'
,'264227V'
,'264228V'
,'265633V'
,'265638V'
,'265645V'
,'265648V'
,'265650V'
,'265651V'
,'260103V'
,'260107V'
,'260112V'
,'260121V'
,'260239V'
,'264483V'
,'264484V'
,'265059V'
,'265063V'
,'265071V'
,'265073V'
,'265075V'
,'265079V'
,'259691V'
,'259692V'
,'265208V'
,'265211V'
,'265815V'
,'265817V'
,'264830V'
,'258913V'
,'264623V'
,'264833V'
,'264835V'
,'260403V'
,'264625V'
,'264734V'
,'264736V'
,'264936V'
,'264938V'
,'255076V'
,'255372V'
,'258179V'
,'258903V'
,'258915V'
,'258993V'
,'259179V'
,'259991V'
,'260019V'
,'264626V'
,'264629V'
,'264633V'
,'264656V'
,'264658V'
,'264669V'
,'264672V'
,'264674V'
,'264678V'
,'264680V'
,'264682V'
,'264689V'
,'264691V'
,'264702V'
,'264709V'
,'264711V'
,'264738V'
,'264742V'
,'264776V'
,'264793V'
,'264796V'
,'264859V'
,'264861V'
,'264865V'
,'264934V'
,'266198V'
,'266377V'
,'266379V'
,'266381V'
,'255063V'
,'256230V'
,'256609V'
,'258917V'
,'259177V'
,'259936V'
,'248775V'
,'256613V'
,'264631V'
,'264681V'
,'264713V'
,'264740V'
,'264746V'
,'264789V'
,'264801V'
,'264838V'
,'264843V'
,'264845V'
,'264847V'
,'264863V'
,'266140V'
,'266142V'
,'260718V'
,'264821V'
,'265128V'
,'264585V'
,'267438V'
,'258912V'
,'259188V'
,'264764V'
,'264823V'
,'258181V'
,'258409V'
,'258994V'
,'259190V'
,'260704V'
,'264596V'
,'264601V'
,'264718V'
,'264720V'
,'264722V'
,'264724V'
,'264726V'
,'264728V'
,'264758V'
,'264760V'
,'266221V'
,'266230V'
,'266243V'
,'266245V'
,'266249V'
,'266262V'
,'266265V'
,'266269V'
,'266281V'
,'266287V'
,'257826V'
,'258918V'
,'258973V'
,'264756V'
,'259192V'
,'264608V'
,'264610V'
,'264730V'
,'264732V'
,'264762V'
,'264869V'
,'266374V'
,'254729V'
,'257259V'
,'257261V'
,'257266V'
,'257267V'
,'257268V'
,'257269V'
,'260722V'
,'260723V'
,'260724V'
,'260725V'
,'260726V'
,'260727V'
,'260728V'
,'260729V'
,'260730V'
,'260731V'
,'260732V'
,'260735V'
,'260736V'
,'260737V'
,'260738V'
,'260739V'
,'260740V'
,'260741V'
,'260742V'
,'260743V'
,'260744V'
,'260745V'
,'260746V'
,'260747V'
,'260748V'
,'260749V'
,'260750V'
,'260751V'
,'260753V'
,'260754V'
,'260755V'
,'260756V'
,'260757V'
,'260758V'
,'260759V'
,'260760V'
,'260761V'
,'260762V'
,'260763V'
,'260764V'
,'260765V'
,'260767V'
,'260768V'
,'260769V'
,'260770V'
,'260771V'
,'260772V'
,'260773V'
,'260774V'
,'260775V'
,'260776V'
,'260777V'
,'258185V'
,'260451V'
,'260510V'
,'264693V'
,'257305V'
,'257311V'
,'257312V'
,'257314V'
,'257315V'
,'257318V'
,'260616V'
,'260617V'
,'260618V'
,'260619V'
,'260620V'
,'260621V'
,'260626V'
,'260627V'
,'260628V'
,'260629V'
,'260630V'
,'260631V'
,'260632V'
,'260634V'
,'260635V'
,'260636V'
,'260637V'
,'260638V'
,'260639V'
,'260671V'
,'260675V'
,'260676V'
,'260681V'
,'260683V'
,'260687V'
,'260696V'
,'260697V'
,'260698V'
,'260699V'
,'260700V'
,'260706V'
,'260707V'
,'260708V'
,'260709V'
,'260711V'
,'258183V'
,'260496V'
,'267099V'
,'258186V'
,'260453V'
,'260501V'
,'264699V'
,'257274V'
,'257275V'
,'257276V'
,'257279V'
,'260513V'
,'260514V'
,'260515V'
,'260517V'
,'260518V'
,'260519V'
,'260520V'
,'260523V'
,'260524V'
,'260527V'
,'260529V'
,'260530V'
,'260538V'
,'260540V'
,'260542V'
,'260543V'
,'260544V'
,'260545V'
,'260546V'
,'260547V'
,'260548V'
,'260549V'
,'258184V'
,'260455V'
,'260507V'
,'264697V'
,'255019V'
,'255023V'
,'255029V'
,'255034V'
,'255038V'
,'255042V'
,'255046V'
,'255053V'
,'266256V'
,'266268V'
,'266273V'
,'266284V'
,'266296V'
,'266355V'
,'266416V'
,'266420V'
,'266427V'
,'266431V'
,'258182V'
,'260457V'
,'260498V'
,'267097V'
,'266397V'
,'266399V'
,'266401V'
,'266403V'
,'266405V'
,'257770V'
,'260603V'
,'264197V'
,'264281V'
,'255235V'
,'258465V'
,'264283V'
,'264337V'
,'254914V'
,'264136V'
,'264299V'
,'264331V'
,'264541V'
,'264543V'
,'265614V'
,'264082V'
,'264094V'
,'264139V'
,'264187V'
,'264195V'
,'264199V'
,'264202V'
,'264782V'
,'265835V'
,'265839V'
,'248866V'
,'255984V'
,'255986V'
,'257829V'
,'257830V'
,'257927V'
,'257982V'
,'257983V'
,'261126V'
,'261131V'
,'264086V'
,'264090V'
,'264155V'
,'264157V'
,'264159V'
,'264191V'
,'264209V'
,'264286V'
,'264995V'
,'264997V'
,'255091V'
,'261077V'
,'261080V'
,'261082V'
,'261084V'
,'261086V'
,'263555V'
,'264289V'
,'264291V'
,'264294V'
,'264297V'
,'264346V'
,'264367V'
,'264374V'
,'264440V'
,'264073V'
,'264071V'
,'264062V'
,'264546V'
,'260811V'
,'260910V'
,'260964V'
,'260969V'
,'260971V'
,'264022V'
,'264054V'
,'264056V'
,'264149V'
,'264151V'
,'264237V'
,'264242V'
,'264271V'
,'266315V'
,'264058V'
,'264060V'
,'264235V'
,'266483V'
,'266628V'
,'257904V'
,'264410V'
,'264704V'
,'252572V'
,'264113V'
,'264097V'
,'264111V'
,'264706V'
,'257932V'
,'260804V'
,'260808V'
,'264080V'
,'264566V'
,'264573V'
,'266240V'
,'254646V'
,'264075V'
,'264109V'
,'264145V'
,'264166V'
,'264200V'
,'264206V'
,'264215V'
,'265013V'
,'265015V'
,'265019V'
,'257903V'
,'264078V'
,'264701V'
,'258921V'
,'258922V'
,'265725V'
,'256762V'
,'258449V'
,'258450V'
,'258928V'
,'258929V'
,'258930V'
,'258931V'
,'260104V'
,'267472V'
,'267474V'
,'267476V'
,'267481V'
,'267485V'
,'267491V'
,'267523V'
,'267526V'
,'267529V'
,'267531V'
,'267534V'
,'267536V'
,'256333V'
,'266487V'
,'266490V'
,'266494V'
,'258084V'
,'259303V'
,'243671V'
,'260106V'
,'256346V'
,'256336V'
,'261701V'
,'258079V'
,'258080V'
,'267271V'
,'258806V'
,'265728V'
,'256165V'
,'256166V'
,'256169V'
,'258744V'
,'258727V'
,'267057V'
,'267059V'
,'267061V'
,'267065V'
,'267075V'
,'267077V'
,'267079V'
,'267081V'
,'267128V'
,'267136V'
,'267140V'
,'267144V'
,'267153V'
,'267161V'
,'267167V'
,'267169V'
,'267207V'
,'267209V'
,'267216V'
,'267219V'
,'263066V'
,'263068V'
,'263070V'
,'263072V'
,'263074V'
,'263076V'
,'263078V'
,'263080V'
,'262652V'
,'262654V'
,'262656V'
,'262658V'
,'262660V'
,'262662V'
,'263085V'
,'263087V'
,'263090V'
,'263095V'
,'263102V'
,'263104V'
,'263106V'
,'263111V'
,'263113V'
,'263117V'
,'263119V'
,'263121V'
,'263123V'
,'263125V'
,'263127V'
,'263130V'
,'263138V'
,'263142V'
,'263165V'
,'263167V'
,'263169V'
,'263171V'
,'263174V'
,'263176V'
,'263178V'
,'263180V'
,'263182V'
,'263189V'
,'262664V'
,'262666V'
,'262668V'
,'262670V'
,'262686V'
,'262688V'
,'262690V'
,'262692V'
,'262694V'
,'262697V'
,'262700V'
,'262702V'
,'262704V'
,'262706V'
,'262708V'
,'262710V'
,'262712V'
,'265029V'
,'265031V'
,'265033V'
,'265035V'
,'265042V'
,'265047V'
,'265052V'
,'265055V'
,'265056V'
,'265057V'
,'265058V'
,'265381V'
,'265389V'
,'265392V'
,'265396V'
,'265400V'
,'265413V'
,'265418V'
,'265420V'
,'265422V'
,'265425V'
,'265428V'
,'265432V'
,'265434V'
,'265437V'
,'265442V'
,'265446V'
,'265449V'
,'265451V'
,'256254V'
,'256272V'
,'257043V'
,'257044V'
,'257341V'
,'257343V'
,'257354V'
,'257355V'
,'267229V'
,'267231V'
,'267233V'
,'267236V'
,'267239V'
,'257112V'
,'257174V'
,'259726V'
,'260230V'
,'260605V'
,'260608V'
,'260611V'
,'261278V'
,'261280V'
,'261282V'
,'261284V'
,'261286V'
,'261288V'
,'261318V'
,'261323V'
,'261328V'
,'261335V'
,'261348V'
,'261361V'
,'264468V'
,'264470V'
,'264473V'
,'260614V'
,'260659V'
,'260661V'
,'260663V'
,'260665V'
,'260670V'
,'260672V'
,'260674V'
,'260677V'
,'260679V'
,'260682V'
,'260684V'
,'262584V'
,'262586V'
,'262588V'
,'262590V'
,'262592V'
,'257220V'
,'257222V'
,'257223V'
,'262728V'
,'262730V'
,'262736V'
,'262738V'
,'262740V'
,'262742V'
,'262749V'
,'262758V'
,'262761V'
,'262763V'
,'262765V'
,'262767V'
,'262769V'
,'262771V'
,'262773V'
,'262775V'
,'262777V'
,'257058V'
,'257062V'
,'257608V'
,'257609V'
,'257611V'
,'257612V'
,'257613V'
,'262837V'
,'262838V'
,'262839V'
,'262843V'
,'262845V'
,'262847V'
,'262849V'
,'262851V'
,'262853V'
,'262855V'
,'262868V'
,'262879V'
,'262881V'
,'262883V'
,'262885V'
,'262887V'
,'262889V'
,'262891V'
,'262893V'
,'262895V'
,'267062V'
,'267066V'
,'267068V'
,'267071V'
,'263128V'
,'263132V'
,'263135V'
,'263139V'
,'263143V'
,'263147V'
,'263149V'
,'263152V'
,'263154V'
,'263203V'
,'263206V'
,'263208V'
,'263210V'
,'262965V'
,'262969V'
,'262971V'
,'262974V'
,'262978V'
,'262988V'
,'263014V'
,'263017V'
,'263019V'
,'263021V'
,'263023V'
,'263025V'
,'263027V'
,'263029V'
,'263031V'
,'263033V'
,'263035V'
,'263037V'
,'263039V'
,'263041V'
,'263043V'
,'263045V'
,'263048V'
,'263050V'
,'263052V'
,'263054V'
,'263056V'
,'263058V'
,'263060V'
,'263062V'
,'256205V'
,'257381V'
,'262461V'
,'262463V'
,'262465V'
,'262467V'
,'262469V'
,'262471V'
,'262473V'
,'262475V'
,'263199V'
,'263201V'
,'263216V'
,'263219V'
,'263221V'
,'263224V'
,'263227V'
,'263232V'
,'263236V'
,'263241V'
,'263243V'
,'263249V'
,'263252V'
,'263256V'
,'263259V'
,'263261V'
,'266641V'
,'260480V'
,'260485V'
,'264584V'
,'265269V'
,'265276V'
,'265279V'
,'266637V'
,'266639V'
,'266643V'
,'266645V'
,'266647V'
,'266649V'
,'262604V'
,'262606V'
,'262608V'
,'262610V'
,'262612V'
,'262614V'
,'262616V'
,'262618V'
,'262620V'
,'262622V'
,'262624V'
,'262626V'
,'262628V'
,'262630V'
,'262632V'
,'262634V'
,'262636V'
,'262638V'
,'262640V'
,'262642V'
,'265287V'
,'265289V'
,'265291V'
,'265293V'
,'265295V'
,'265297V'
,'265301V'
,'265312V'
,'265315V'
,'265323V'
,'265330V'
,'265333V'
,'265338V'
,'265341V'
,'265344V'
,'265347V'
,'265353V'
,'265356V'
,'265358V'
,'265360V'
,'265362V'
,'265365V'
,'265367V'
,'265369V'
,'265371V'
,'262478V'
,'262480V'
,'262482V'
,'262484V'
,'262486V'
,'262488V'
,'262490V'
,'262492V'
,'262500V'
,'262505V'
,'262508V'
,'262517V'
,'262520V'
,'262526V'
,'262528V'
,'262530V'
,'262532V'
,'262548V'
,'262550V'
,'262552V'
,'262562V'
,'262568V'
,'262570V'
,'262572V'
,'262574V'
,'262577V'
,'262579V'
,'264816V'
,'265076V'
,'265080V'
,'265082V'
,'265092V'
,'265096V'
,'265098V'
,'265101V'
,'265104V'
,'265107V'
,'265110V'
,'265114V'
,'265118V'
,'265120V'
,'265122V'
,'265124V'
,'265126V'
,'265185V'
,'265188V'
,'265192V'
,'265194V'
,'265243V'
,'265245V'
,'265247V'
,'265249V'
,'265251V'
,'265253V'
,'265255V'
,'265257V'
,'265259V'
,'265266V'
,'265268V'
,'264356V'
,'264353V'
,'261125V'
,'261128V'
,'264269V'
,'264348V'
,'256248V'
,'257832V'
,'257914V'
,'259642V'
,'261101V'
,'261106V'
,'261108V'
,'261134V'
,'261147V'
,'263212V'
,'263214V'
,'264134V'
,'264141V'
,'264143V'
,'264161V'
,'264163V'
,'264256V'
,'264261V'
,'264264V'
,'264826V'
,'265407V'
,'255727V'
,'257913V'
,'258987V'
,'266537V'
,'261137V'
,'261139V'
,'261145V'
,'264266V'
,'264275V'
,'264279V'
,'265002V'
,'265007V'
,'265009V'
,'265011V'
,'265926V'
,'265938V'
,'265940V'
,'265943V'
,'265946V'
,'265948V'
,'265968V'
,'266531V'
,'258966V'
,'265737V'
,'265912V'
,'265513V'
,'265522V'
,'265776V'
,'265897V'
,'261027V'
,'261029V'
,'265239V'
,'265241V'
,'265206V'
,'265210V'
,'265218V'
,'265222V'
,'265224V'
,'265226V'
,'265505V'
,'265687V'
,'265752V'
,'265806V'
,'265890V'
,'265899V'
,'265904V'
,'267398V'
,'265236V'
,'265593V'
,'265608V'
,'265612V'
,'265631V'
,'265228V'
,'265507V'
,'265531V'
,'265535V'
,'265539V'
,'265542V'
,'265547V'
,'265758V'
,'265780V'
,'265810V'
,'265813V'
,'265820V'
,'265830V'
,'265934V'
,'265941V'
,'266144V'
,'266146V'
,'266154V'
,'247492V'
,'265501V'
,'265551V'
,'265556V'
,'265726V'
,'265731V'
,'255767V'
,'258504V'
,'265578V'
,'265666V'
,'259141V'
,'265622V'
,'265670V'
,'265734V'
,'265766V'
,'265795V'
,'265797V'
,'265895V'
,'265914V'
,'266343V'
,'247490V'
,'265230V'
,'265878V'
,'265332V'
,'265348V'
,'265351V'
,'265379V'
,'265406V'
,'265424V'
,'265595V'
,'265602V'
,'265604V'
,'265625V'
,'265875V'
,'266823V'
,'266825V'
,'256146V'
,'256297V'
,'266175V'
,'265537V'
,'265541V'
,'265550V'
,'265563V'
,'265567V'
,'265579V'
,'265587V'
,'265682V'
,'265828V'
,'265867V'
,'265879V'
,'266499V'
,'267419V'
,'267421V'
,'247611V'
,'247621V'
,'256349V'
,'265610V'
,'247498V'
,'265624V'
,'266634V'
,'253346V'
,'265318V'
,'265627V'
,'265696V'
,'266201V'
,'266217V'
,'266237V'
,'266795V'
,'266801V'
,'266804V'
,'266810V'
,'258811V'
,'265141V'
,'265168V'
,'265585V'
,'265616V'
,'265618V'
,'266170V'
,'266172V'
,'266321V'
,'266338V'
,'255621V'
,'258588V'
,'263298V'
,'265154V'
,'265673V'
,'265677V'
,'265822V'
,'265824V'
,'265861V'
,'265869V'
,'265881V'
,'265885V'
,'255622V'
,'258608V'
,'265865V'
,'265873V'
,'265887V'
,'265974V'
,'267413V'
,'247516V'
,'265186V'
,'265414V'
,'265620V'
,'265871V'
,'265889V'
,'265893V'
,'265907V'
,'265925V'
,'265196V'
,'265219V'
,'265273V'
,'266700V'
,'259451V'
,'259455V'
,'266677V'
,'249434V'
,'266671V'
,'266675V'
,'267403V'
,'248433V'
,'266664V'
,'266673V'
,'267407V'
,'267409V'
,'258804V'
,'265260V'
,'265265V'
,'266698V'
,'267041V'
,'267405V'
,'267454V'
,'264519V'
,'266192V'
,'266194V'
,'266197V'
,'266206V'
,'266211V'
,'266620V'
,'266624V'
,'266633V'
,'258800V'
,'258975V'
,'265149V'
,'265203V'
,'265214V'
,'265216V'
,'265262V'
,'265569V'
,'266622V'
,'266630V'
,'266704V'
,'266740V'
,'266744V'
,'265171V'
,'266706V'
,'266709V'
,'266741V'
,'258933V'
,'261096V'
,'265158V'
,'266390V'
,'266392V'
,'266977V'
,'267007V'
,'267009V'
,'267011V'
,'267014V'
,'267020V'
,'256299V'
,'259347V'
,'261041V'
,'266517V'
,'262338V'
,'266679V'
,'266685V'
,'266690V'
,'266694V'
,'266703V'
,'266714V'
,'266725V'
,'266729V'
,'266731V'
,'259023V'
,'259047V'
,'266384V'
,'266394V'
,'266683V'
,'266711V'
,'266947V'
,'266950V'
,'266952V'
,'266957V'
,'266959V'
,'266961V'
,'266967V'
,'266969V'
,'266971V'
,'266974V'
,'266984V'
,'266987V'
,'266991V'
,'266386V'
,'266388V'
,'266994V'
,'266997V'
,'266999V'
,'267004V'
,'266692V'
,'267384V'
,'267478V'
,'267494V'
,'267514V'
,'267521V'
,'259436V'
,'261094V'
,'266898V'
,'266782V'
,'267431V'
,'266734V'
,'266805V'
,'266808V'
,'266811V'
,'266814V'
,'266817V'
,'266819V'
,'267044V'
,'267046V'
,'267052V'
,'267054V'
,'266821V'
,'266876V'
,'266883V'
,'266892V'
,'255868V'
,'266425V'
,'266430V'
,'266434V'
,'266436V'
,'266788V'
,'266881V'
,'267450V'
,'267452V'
,'267483V'
,'267508V'
,'266945V'
,'267029V'
,'267033V'
,'267037V'
,'267048V'
,'253051V'
,'254920V'
,'256310V'
,'258798V'
,'264522V'
,'266738V'
,'266943V'
,'256036V'
,'256037V'
,'258840V'
,'258969V'
,'265566V'
,'267382V'
,'266736V'
,'265140V'
,'265169V'
,'265175V'
,'266364V'
,'267173V'
,'267196V'
,'259338V'
,'266510V'
,'266347V'
,'266349V'
,'266351V'
,'266353V'
,'266370V'
,'267151V'
,'267198V'
,'267200V'
,'267212V'
,'267423V'
,'267426V'
,'267428V'
,'267430V'
,'267436V'
,'267455V'
,'267461V'
,'267467V'
,'258760V'
,'259025V'
,'266366V'
,'266519V'
,'266722V'
,'266372V'
,'267121V'
,'267127V'
,'267130V'
,'267175V'
,'267177V'
,'267180V'
,'267186V'
,'267189V'
,'267135V'
,'267139V'
,'267143V'
,'267146V'
,'267149V'
,'266368V'
,'267154V'
,'267157V'
,'267171V'
,'267193V'
,'267204V'
,'267206V'
,'267210V'
,'265148V'
,'265694V'
,'264392V'
,'264394V'
,'264396V'
,'264398V'
,'266458V'
,'266460V'
,'266462V'
,'266464V'
,'266466V'
,'266468V'
,'264402V'
,'264404V'
,'264407V'
,'264413V'
,'263367V'
,'263372V'
,'263380V'
,'263388V'
,'262912V'
,'262914V'
,'262917V'
,'262922V'
,'262927V'
,'262931V'
,'262935V'
,'262939V'
,'262947V'
,'262955V'
,'262967V'
,'262972V'
,'263155V'
,'263158V'
,'263160V'
,'263162V'
,'263290V'
,'263292V'
,'263296V'
,'263300V'
,'263303V'
,'263321V'
,'263323V'
,'263325V'
,'263327V'
,'263329V'
,'263331V'
,'263333V'
,'263335V'
,'263336V'
,'263339V'
,'263341V'
,'263343V'
,'263345V'
,'263347V'
,'263349V'
,'256580V'
,'263306V'
,'263504V'
,'263506V'
,'263513V'
,'263516V'
,'263518V'
,'263520V'
,'263523V'
,'263529V'
,'263531V'
,'263533V'
,'263535V'
,'263537V'
,'263539V'
,'263541V'
,'263543V'
,'263545V'
,'263547V'
,'263549V'
,'263551V'
,'263365V'
,'263369V'
,'263371V'
,'263375V'
,'263378V'
,'263384V'
,'263389V'
,'263392V'
,'263890V'
,'263892V'
,'263910V'
,'263914V'
,'263916V'
,'263918V'
,'263921V'
,'263924V'
,'263926V'
,'263930V'
,'263934V'
,'263937V'
,'263940V'
,'263945V'
,'263947V'
,'263950V'
,'263952V'
,'263955V'
,'263962V'
,'263973V'
,'263984V'
,'263991V'
,'265272V'
,'265280V'
,'265283V'
,'265285V'
,'265299V'
,'265302V'
,'265305V'
,'265307V'
,'265309V'
,'265311V'
,'265316V'
,'265320V'
,'265324V'
,'265326V'
,'265329V'
,'256055V'
,'256056V'
,'263717V'
,'263722V'
,'263726V'
,'263733V'
,'263739V'
,'263742V'
,'263749V'
,'263761V'
,'263776V'
,'263783V'
,'263787V'
,'263794V'
,'263796V'
,'263798V'
,'263800V'
,'263802V'
,'263851V'
,'263853V'
,'263855V'
,'263857V'
,'263859V'
,'263861V'
,'263863V'
,'263865V'
,'263867V'
,'263869V'
,'263871V'
,'263873V'
,'263875V'
,'263877V'
,'263879V'
,'263881V'
,'263883V'
,'265460V'
,'265465V'
,'265467V'
,'265469V'
,'265472V'
,'265474V'
,'265488V'
,'265490V'
,'265492V'
,'265494V'
,'263675V'
,'263677V'
,'263679V'
,'263681V'
,'263683V'
,'263685V'
,'263687V'
,'263689V'
,'263691V'
,'263693V'
,'263695V'
,'263697V'
,'263699V'
,'263702V'
,'263704V'
,'263706V'
,'263708V'
,'263712V'
,'263741V'
,'263744V'
,'263747V'
,'263750V'
,'263753V'
,'263755V'
,'263757V'
,'263759V'
,'265759V'
,'265762V'
,'265764V'
,'265767V'
,'265770V'
,'265772V'
,'265774V'
,'265777V'
,'265972V'
,'265976V'
,'265982V'
,'266007V'
,'266013V'
,'266016V'
,'266021V'
,'266025V'
,'266028V'
,'266031V'
,'266033V'
,'266036V'
,'266039V'
,'266099V'
,'266104V'
,'266108V'
,'266112V'
,'265373V'
,'265375V'
,'265377V'
,'265380V'
,'265383V'
,'265386V'
,'265390V'
,'265395V'
,'265399V'
,'265404V'
,'263612V'
,'263616V'
,'263627V'
,'263630V'
,'263632V'
,'263638V'
,'263642V'
,'263645V'
,'263648V'
,'263651V'
,'263655V'
,'263663V'
,'263665V'
,'263667V'
,'263669V'
,'263671V'
,'263673V'
,'263762V'
,'263772V'
,'263774V'
,'263777V'
,'263781V'
,'263784V'
,'263788V'
,'263790V'
,'266114V'
,'266134V'
,'255643V'
,'255716V'
,'255717V'
,'255719V'
,'265454V'
,'265456V'
,'265458V'
,'265461V'
,'265464V'
,'265478V'
,'265480V'
,'265483V'
,'265486V'
,'259460V'
,'260028V'
,'260029V'
,'260030V'
,'260046V'
,'260133V'
,'260135V'
,'260139V'
,'260140V'
,'260143V'
,'260146V'
,'260149V'
,'260150V'
,'260152V'
,'260156V'
,'260157V'
,'260160V'
,'260161V'
,'264115V'
,'264117V'
,'264119V'
,'264121V'
,'264123V'
,'264125V'
,'2644971V'
,'2645031V'
,'2645111V'
,'2645151V'
,'2647681V'
,'2648831V'
,'2650211V'
,'2660722V'
,'2661002V'
,'264039V'
,'264041V'
,'267202V'
,'2644972V'
,'2645032V'
,'2645112V'
,'2645152V'
,'2647682V'
,'2648832V'
,'2650212V'
,'2660721V'
,'2661001V'
,'2673112V'
,'2556762V'
,'2565962V'
,'2647722V'
,'2648052V'
,'2648151V'
,'2648241V'
,'2648371V'
,'2648541V'
,'2648681V'
,'2660631V'
,'2662462V'
,'2662801V'
,'2662932V'
,'254997V'
,'254999V'
,'264023V'
,'264028V'
,'264032V'
,'264035V'
,'264051V'
,'266205V'
,'264047V'
,'2556761V'
,'2565961V'
,'2647721V'
,'2648051V'
,'2648152V'
,'2648242V'
,'2648372V'
,'2648542V'
,'2648682V'
,'2660632V'
,'2662461V'
,'2662802V'
,'2662931V'
,'261215V'
,'267298V'
,'267303V'
,'267305V'
,'260922V'
,'260924V'
,'260935V'
,'260939V'
,'255304V'
,'255305V'
,'256819V'
,'265555V'
,'265558V'
,'265571V'
,'265572V'
,'265574V'
,'265582V'
,'267165V'
,'267234V'
,'267238V'
,'267251V'
,'267253V'
,'267275V'
,'267277V'
,'267279V'
,'267283V'
,'265596V'
,'265599V'
,'266666V'
,'264648V'
,'264649V'
,'264650V'
,'264651V'
,'249478V'
,'256655V'
,'258697V'
,'258106V'
,'258107V'
,'258592V'
,'261712V'
,'263428V'
,'263996V'
,'264389V'
,'265716V'
,'256472V'
,'258105V'
,'258582V'
,'263591V'
,'263895V'
,'265717V'
,'263593V'
,'263661V'
,'256471V'
,'256648V'
,'258595V'
,'264020V'
,'264359V'
,'263662V'
,'258581V'
,'258603V'
,'264285V'
,'256412V'
,'262900V'
,'262901V'
,'262902V'
,'262957V'
,'264292V'
,'264301V'
,'264659V'
,'264660V'
,'256840V'
,'256841V'
,'265720V'
,'265739V'
,'265740V'
,'265741V'
,'265746V'
,'265747V'
,'266357V'
,'266359V'
,'266362V'
,'267164V'
,'266097V'
,'266215V'
,'266223V'
,'266225V'
,'266227V'
,'266232V'
,'266235V'
,'266527V'
,'266538V'
,'266542V'
,'266547V'
,'266559V'
,'266560V'
,'266562V'
,'266569V'
,'266572V'
,'266574V'
,'266577V'
,'266590V'
,'266591V'
,'266593V'
,'266595V'
,'266603V'
,'266605V'
,'266606V'
,'266607V'
,'266609V'
,'266749V'
,'266753V'
,'266754V'
,'266762V'
,'266766V'
,'266849V'
,'266852V'
,'266853V'
,'266854V'
,'266860V'
,'266864V'
,'266865V'
,'266866V'
,'266895V'
,'266899V'
,'266903V'
,'266905V'
,'266923V'
,'266924V'
,'266925V'
,'266926V'
,'264231V'
,'264232V'
,'264233V'
,'264238V'
,'262877V'
,'264008V'
,'264010V'
,'264043V'
,'264045V'
,'266654V'
,'266656V'
,'266657V'
,'265949V'
,'265950V'
,'265952V'
,'265954V'
,'261591V'
,'265167V'
,'256409V'
,'265435V'
,'265438V'
,'260385V'
,'260393V'
,'266084V'
,'266089V'
,'266091V'
,'266093V'
,'266522V')
group by PEDIDO ) t1 on t1.PEDIDO = COMPRAS.PEDIDO /*and t1.produto=compras_produto.PRODUTO and t1.cor_produto = compras_produto.cor_produto*/



update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258433V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258438V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264379V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264380V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264381V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264382V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264383V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264384V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265664V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263559V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263564V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263576V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264216V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264218V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264219V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264220V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264221V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264222V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264223V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264224V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264225V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264226V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264227V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264228V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265633V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265638V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265645V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265648V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265650V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265651V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260103V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260107V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260112V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260121V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '260239V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264483V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264484V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265059V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265063V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265071V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265073V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265075V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265079V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '259691V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '259692V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265208V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265211V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265815V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265817V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264830V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258913V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264623V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264833V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264835V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260403V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264625V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264734V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264736V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264936V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264938V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255076V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255372V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258179V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258903V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258915V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258993V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '259179V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '259991V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260019V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264626V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264629V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264633V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264656V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264658V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264669V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264672V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264674V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264678V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264680V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264682V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264689V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264691V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264702V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264709V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264711V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264738V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264742V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264776V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264793V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264796V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264859V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264861V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264865V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264934V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266198V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266377V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266379V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266381V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255063V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256230V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256609V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258917V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '259177V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '259936V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '248775V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256613V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264631V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264681V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264713V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264740V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264746V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264789V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264801V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264838V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264843V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264845V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264847V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264863V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266140V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266142V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260718V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264821V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265128V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264585V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267438V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258912V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '259188V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264764V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264823V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258181V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258409V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258994V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '259190V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260704V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264596V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264601V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264718V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264720V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264722V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264724V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264726V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264728V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264758V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264760V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266221V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266230V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266243V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266245V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266249V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266262V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266265V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266269V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266281V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266287V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257826V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258918V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258973V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264756V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '259192V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264608V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264610V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264730V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264732V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264762V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264869V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266374V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '254729V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257259V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257261V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257266V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257267V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257268V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257269V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260722V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260723V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260724V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260725V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260726V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260727V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260728V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260729V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260730V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260731V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260732V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260735V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260736V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260737V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260738V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260739V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260740V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260741V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260742V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260743V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260744V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260745V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260746V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260747V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260748V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260749V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260750V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260751V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260753V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260754V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260755V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260756V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260757V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260758V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260759V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260760V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260761V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260762V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260763V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260764V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260765V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260767V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260768V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260769V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260770V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260771V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260772V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260773V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260774V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260775V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260776V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260777V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258185V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260451V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260510V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264693V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257305V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257311V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257312V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257314V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257315V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257318V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260616V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260617V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260618V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260619V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260620V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260621V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260626V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260627V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260628V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260629V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260630V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260631V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260632V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260634V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260635V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260636V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260637V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260638V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260639V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260671V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260675V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260676V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260681V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260683V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260687V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260696V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260697V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260698V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260699V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260700V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260706V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260707V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260708V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260709V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260711V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258183V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260496V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267099V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258186V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260453V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260501V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264699V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257274V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257275V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257276V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257279V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260513V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260514V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260515V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260517V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260518V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260519V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260520V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260523V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260524V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260527V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260529V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260530V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260538V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260540V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260542V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260543V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260544V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260545V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260546V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260547V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260548V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260549V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258184V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260455V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260507V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264697V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255019V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255023V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255029V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255034V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255038V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255042V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255046V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255053V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266256V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266268V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266273V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266284V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266296V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266355V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266416V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266420V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266427V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266431V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258182V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260457V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260498V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267097V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266397V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266399V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266401V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266403V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266405V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257770V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260603V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264197V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264281V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255235V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258465V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264283V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264337V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '254914V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264136V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264299V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264331V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264541V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264543V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265614V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264082V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264094V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264139V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264187V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264195V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264199V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264202V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264782V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265835V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265839V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '248866V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255984V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255986V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257829V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257830V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257927V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257982V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257983V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261126V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261131V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264086V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264090V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264155V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264157V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264159V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264191V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264209V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264286V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264995V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264997V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255091V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261077V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261080V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261082V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261084V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261086V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263555V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264289V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264291V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264294V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264297V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264346V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264367V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264374V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264440V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264073V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264071V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264062V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264546V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260811V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260910V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260964V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260969V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260971V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264022V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264054V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264056V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264149V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264151V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264237V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264242V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264271V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266315V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264058V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264060V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264235V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266483V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266628V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257904V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264410V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264704V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '252572V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264113V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264097V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264111V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264706V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257932V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260804V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260808V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264080V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264566V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264573V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266240V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '254646V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264075V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264109V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264145V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264166V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264200V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264206V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264215V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265013V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265015V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265019V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257903V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264078V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264701V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258921V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258922V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265725V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256762V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258449V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '258450V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258928V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258929V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258930V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258931V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260104V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267472V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267474V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267476V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267481V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267485V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267491V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267523V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267526V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267529V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267531V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267534V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267536V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256333V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266487V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266490V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266494V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258084V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '259303V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '243671V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260106V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256346V';
update compras set erp_total_qtd_distrib = 4, erp_total_caixas_original = 4 where pedido = '256336V';
update compras set erp_total_qtd_distrib = 4, erp_total_caixas_original = 4 where pedido = '261701V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258079V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258080V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267271V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258806V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265728V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256165V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256166V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256169V';
update compras set erp_total_qtd_distrib = 4, erp_total_caixas_original = 4 where pedido = '258744V';
update compras set erp_total_qtd_distrib = 4, erp_total_caixas_original = 4 where pedido = '258727V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267057V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267059V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267061V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267065V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267075V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267077V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267079V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267081V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267128V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267136V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267140V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267144V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267153V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267161V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267167V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267169V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267207V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267209V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267216V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267219V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263066V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263068V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263070V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263072V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263074V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263076V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263078V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263080V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262652V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262654V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262656V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262658V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262660V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262662V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263085V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263087V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263090V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263095V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263102V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263104V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263106V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263111V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263113V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263117V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263119V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263121V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263123V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263125V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263127V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263130V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263138V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263142V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263165V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263167V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263169V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263171V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263174V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263176V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263178V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263180V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263182V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263189V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262664V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262666V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262668V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262670V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262686V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262688V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262690V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262692V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262694V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262697V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262700V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262702V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262704V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262706V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262708V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262710V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262712V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265029V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265031V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265033V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265035V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265042V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265047V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265052V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265055V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265056V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265057V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265058V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265381V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265389V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265392V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265396V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265400V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265413V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265418V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265420V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265422V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265425V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265428V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265432V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265434V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265437V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265442V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265446V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265449V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265451V';
update compras set erp_total_qtd_distrib = 4, erp_total_caixas_original = 4 where pedido = '256254V';
update compras set erp_total_qtd_distrib = 4, erp_total_caixas_original = 4 where pedido = '256272V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257043V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257044V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257341V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257343V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257354V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257355V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267229V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267231V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267233V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267236V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267239V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257112V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257174V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '259726V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260230V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260605V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260608V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260611V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261278V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261280V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261282V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261284V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261286V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261288V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261318V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261323V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261328V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261335V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261348V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261361V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264468V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264470V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264473V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260614V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260659V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260661V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260663V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260665V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260670V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260672V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260674V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260677V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260679V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260682V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260684V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262584V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262586V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262588V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262590V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262592V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257220V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257222V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257223V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262728V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262730V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262736V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262738V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262740V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262742V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262749V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262758V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262761V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262763V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262765V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262767V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262769V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262771V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262773V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262775V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262777V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257058V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257062V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257608V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257609V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257611V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257612V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257613V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262837V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262838V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262839V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262843V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262845V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262847V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262849V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262851V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262853V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262855V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262868V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262879V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262881V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262883V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262885V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262887V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262889V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262891V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262893V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262895V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267062V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267066V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267068V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267071V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263128V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263132V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263135V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263139V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263143V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263147V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263149V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263152V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263154V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263203V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263206V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263208V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263210V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262965V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262969V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262971V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262974V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262978V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262988V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263014V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263017V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263019V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263021V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263023V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263025V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263027V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263029V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263031V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263033V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263035V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263037V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263039V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263041V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263043V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263045V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263048V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263050V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263052V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263054V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263056V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263058V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263060V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263062V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256205V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257381V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262461V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262463V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262465V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262467V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262469V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262471V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262473V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262475V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263199V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263201V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263216V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263219V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263221V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263224V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263227V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263232V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263236V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263241V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263243V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263249V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263252V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263256V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263259V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263261V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266641V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260480V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260485V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264584V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265269V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265276V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265279V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266637V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266639V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266643V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266645V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266647V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266649V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262604V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262606V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262608V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262610V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262612V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262614V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262616V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262618V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262620V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262622V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262624V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262626V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262628V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262630V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262632V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262634V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262636V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262638V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262640V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262642V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265287V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265289V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265291V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265293V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265295V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265297V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265301V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265312V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265315V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265323V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265330V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265333V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265338V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265341V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265344V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265347V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265353V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265356V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265358V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265360V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265362V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265365V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265367V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265369V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265371V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262478V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262480V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262482V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262484V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262486V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262488V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262490V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262492V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262500V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262505V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262508V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262517V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262520V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262526V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262528V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262530V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262532V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262548V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262550V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262552V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262562V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262568V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262570V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262572V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262574V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262577V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262579V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264816V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265076V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265080V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265082V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265092V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265096V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265098V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265101V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265104V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265107V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265110V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265114V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265118V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265120V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265122V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265124V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265126V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265185V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265188V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265192V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265194V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265243V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265245V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265247V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265249V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265251V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265253V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265255V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265257V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265259V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265266V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265268V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264356V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264353V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261125V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261128V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264269V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264348V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256248V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257832V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257914V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '259642V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261101V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261106V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261108V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261134V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261147V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263212V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263214V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264134V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264141V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264143V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264161V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264163V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264256V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264261V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264264V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264826V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265407V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255727V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '257913V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258987V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266537V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261137V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261139V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261145V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264266V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264275V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264279V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265002V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265007V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265009V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265011V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265926V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265938V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265940V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265943V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265946V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265948V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265968V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266531V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '258966V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265737V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265912V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265513V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265522V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265776V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265897V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '261027V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '261029V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265239V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265241V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265206V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265210V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265218V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265222V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265224V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265226V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265505V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265687V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265752V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265806V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265890V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265899V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265904V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267398V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265236V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265593V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265608V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265612V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265631V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265228V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265507V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265531V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265535V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265539V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265542V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265547V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265758V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265780V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265810V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265813V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265820V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265830V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265934V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265941V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266144V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266146V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266154V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '247492V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265501V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265551V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265556V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265726V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265731V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '255767V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '258504V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265578V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265666V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '259141V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265622V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265670V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265734V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265766V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265795V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265797V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265895V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265914V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266343V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '247490V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265230V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265878V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265332V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265348V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265351V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265379V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265406V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265424V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265595V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265602V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265604V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265625V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265875V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266823V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266825V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '256146V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '256297V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266175V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265537V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265541V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265550V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265563V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265567V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265579V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265587V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265682V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265828V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265867V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265879V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266499V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267419V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267421V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '247611V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '247621V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '256349V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265610V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '247498V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265624V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266634V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '253346V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265318V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265627V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265696V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266201V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266217V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266237V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266795V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266801V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266804V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266810V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '258811V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265141V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265168V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265585V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265616V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265618V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266170V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266172V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266321V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266338V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '255621V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '258588V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263298V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265154V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265673V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265677V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265822V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265824V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265861V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265869V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265881V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265885V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '255622V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '258608V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265865V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265873V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265887V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265974V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267413V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '247516V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265186V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265414V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265620V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265871V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265889V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265893V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265907V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265925V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265196V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265219V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265273V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266700V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '259451V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '259455V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266677V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '249434V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266671V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266675V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267403V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '248433V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266664V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266673V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267407V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267409V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '258804V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265260V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265265V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266698V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267041V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267405V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267454V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '264519V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266192V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266194V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266197V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266206V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266211V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266620V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266624V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266633V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '258800V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '258975V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265149V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265203V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265214V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265216V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265262V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265569V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266622V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266630V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266704V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266740V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266744V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265171V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266706V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266709V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266741V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '258933V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261096V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265158V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266390V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266392V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266977V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267007V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267009V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267011V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267014V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267020V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '256299V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '259347V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '261041V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266517V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '262338V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266679V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266685V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266690V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266694V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266703V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266714V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266725V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266729V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266731V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '259023V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '259047V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266384V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266394V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266683V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266711V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266947V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266950V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266952V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266957V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266959V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266961V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266967V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266969V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266971V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266974V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266984V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266987V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266991V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266386V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266388V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266994V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266997V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266999V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267004V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266692V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267384V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267478V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267494V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267514V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267521V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '259436V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '261094V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266898V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266782V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267431V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266734V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266805V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266808V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266811V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266814V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266817V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266819V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267044V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267046V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267052V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267054V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266821V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266876V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266883V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266892V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '255868V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266425V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266430V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266434V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266436V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266788V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266881V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267450V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267452V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267483V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267508V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266945V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267029V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267033V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267037V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267048V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '253051V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '254920V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '256310V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '258798V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '264522V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266738V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266943V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '256036V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '256037V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '258840V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '258969V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265566V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267382V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266736V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265140V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265169V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265175V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266364V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267173V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267196V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '259338V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266510V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266347V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266349V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266351V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266353V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266370V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267151V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267198V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267200V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267212V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267423V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267426V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267428V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267430V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267436V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267455V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267461V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267467V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '258760V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '259025V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266366V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266519V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266722V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266372V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267121V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267127V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267130V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267175V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267177V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267180V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267186V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267189V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267135V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267139V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267143V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267146V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267149V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266368V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267154V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267157V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267171V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267193V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267204V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267206V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '267210V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265148V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265694V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '264392V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '264394V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '264396V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '264398V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266458V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266460V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266462V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266464V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266466V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266468V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '264402V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '264404V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '264407V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '264413V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263367V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263372V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263380V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263388V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '262912V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262914V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '262917V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '262922V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '262927V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '262931V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '262935V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '262939V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '262947V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '262955V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '262967V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '262972V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263155V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263158V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263160V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263162V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263290V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263292V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263296V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263300V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263303V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263321V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263323V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263325V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263327V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263329V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263331V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263333V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263335V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263336V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263339V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263341V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263343V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263345V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263347V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263349V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '256580V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263306V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263504V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263506V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263513V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263516V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263518V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263520V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263523V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263529V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263531V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263533V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263535V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263537V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263539V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263541V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263543V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263545V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263547V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263549V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263551V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263365V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263369V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263371V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263375V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263378V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263384V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263389V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263392V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263890V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263892V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263910V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263914V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263916V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263918V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263921V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263924V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263926V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263930V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263934V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263937V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263940V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263945V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263947V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263950V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263952V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263955V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263962V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263973V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263984V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263991V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265272V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265280V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265283V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265285V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265299V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265302V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265305V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265307V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265309V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265311V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265316V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265320V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265324V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265326V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265329V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256055V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256056V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263717V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263722V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263726V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263733V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263739V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263742V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263749V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263761V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263776V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263783V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263787V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263794V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263796V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263798V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263800V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263802V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263851V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263853V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263855V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263857V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263859V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263861V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263863V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263865V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263867V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263869V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263871V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263873V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263875V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263877V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263879V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263881V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263883V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265460V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265465V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265467V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265469V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265472V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265474V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265488V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265490V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265492V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265494V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263675V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263677V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263679V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263681V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263683V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263685V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263687V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263689V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263691V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263693V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263695V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263697V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263699V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263702V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263704V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263706V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263708V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263712V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263741V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263744V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263747V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263750V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263753V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263755V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263757V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263759V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265759V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265762V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265764V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265767V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265770V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265772V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265774V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265777V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265972V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265976V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265982V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266007V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266013V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266016V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266021V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266025V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266028V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266031V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266033V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266036V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266039V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266099V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266104V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266108V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266112V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265373V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265375V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265377V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265380V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265383V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265386V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265390V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265395V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265399V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265404V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263612V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263616V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263627V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263630V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263632V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263638V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263642V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263645V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263648V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263651V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263655V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263663V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263665V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263667V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263669V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263671V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263673V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263762V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263772V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263774V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263777V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263781V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263784V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263788V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '263790V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266114V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '266134V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255643V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255716V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255717V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255719V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265454V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265456V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265458V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265461V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265464V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265478V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265480V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265483V';
update compras set erp_total_qtd_distrib = 3, erp_total_caixas_original = 3 where pedido = '265486V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '259460V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260028V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260029V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260030V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260046V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260133V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260135V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260139V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260140V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260143V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260146V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260149V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260150V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260152V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260156V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260157V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260160V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260161V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264115V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264117V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264119V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264121V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264123V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264125V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2644971V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2645031V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2645111V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2645151V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2647681V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2648831V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2650211V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2660722V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2661002V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264039V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264041V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267202V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2644972V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2645032V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2645112V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2645152V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2647682V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2648832V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2650212V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2660721V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2661001V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2673112V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2556762V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2565962V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2647722V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2648052V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2648151V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2648241V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2648371V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2648541V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2648681V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2660631V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2662462V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2662801V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2662932V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '254997V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '254999V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264023V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264028V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264032V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264035V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264051V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266205V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264047V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2556761V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2565961V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2647721V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2648051V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2648152V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2648242V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2648372V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2648542V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2648682V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2660632V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2662461V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2662802V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '2662931V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261215V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267298V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267303V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267305V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260922V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260924V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260935V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260939V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255304V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '255305V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256819V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265555V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265558V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265571V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265572V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265574V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265582V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267165V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267234V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267238V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267251V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267253V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267275V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267277V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267279V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267283V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265596V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265599V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266666V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264648V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264649V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264650V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264651V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '249478V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256655V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258697V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258106V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258107V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258592V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261712V';
update compras set erp_total_qtd_distrib = 4, erp_total_caixas_original = 4 where pedido = '263428V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263996V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264389V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265716V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256472V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258105V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258582V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263591V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263895V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265717V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263593V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '263661V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256471V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256648V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258595V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264020V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264359V';
update compras set erp_total_qtd_distrib = 4, erp_total_caixas_original = 4 where pedido = '263662V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258581V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '258603V';
update compras set erp_total_qtd_distrib = 4, erp_total_caixas_original = 4 where pedido = '264285V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256412V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262900V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262901V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262902V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262957V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264292V';
update compras set erp_total_qtd_distrib = 4, erp_total_caixas_original = 4 where pedido = '264301V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264659V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264660V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256840V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256841V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265720V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265739V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265740V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265741V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265746V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265747V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266357V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266359V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266362V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '267164V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266097V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266215V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266223V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266225V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266227V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266232V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266235V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266527V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266538V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266542V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266547V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266559V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266560V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266562V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266569V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266572V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266574V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266577V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266590V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266591V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266593V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266595V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266603V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266605V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266606V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266607V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266609V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266749V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266753V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266754V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266762V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266766V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266849V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266852V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266853V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266854V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266860V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266864V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266865V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266866V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266895V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266899V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266903V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266905V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266923V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266924V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266925V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266926V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264231V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264232V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264233V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264238V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '262877V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264008V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264010V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264043V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '264045V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266654V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266656V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266657V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265949V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265950V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265952V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265954V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '261591V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265167V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '256409V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265435V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '265438V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260385V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '260393V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266084V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266089V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266091V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266093V';
update compras set erp_total_qtd_distrib = 2, erp_total_caixas_original = 2 where pedido = '266522V';


