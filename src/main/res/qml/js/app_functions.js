
function indexSections(index) {

    for(var i=0; i<sections_list.length; i++) {
        var name = sections_list[i]
        if (section_ind[name] >= index) {
            section_ind[name] += 1
        }
    }

}

function reAssignIndex() {

    for (var x=0; x<base_mode.length; x++) {
        base_mode[x].ind = x
    }

}
