/*
 * Functions is called with d3.json callback
 * It finds the overlapping documents in the clusters and keeps the stat on the links 2d array (matrix)
 */

function clone(obj) {
    if (null == obj || "object" != typeof obj) return obj;
    var copy = obj.constructor();
    for (var attr in obj) {
        if (obj.hasOwnProperty(attr)) copy[attr] = obj[attr];
    }
    return copy;
}

var maxOverlap = 0;

function FindOverlappingDocs(data, numOfCluster) {
	var nodes = new Array(numOfCluster);
	var overlap = new Array(numOfCluster);
	var totalOverlapLink = 0;
	for( i = 0; i < numOfCluster; i++) {
		overlap[i] = new Array(numOfCluster);
		for( j = 0; j < numOfCluster; j++) {
			overlap[i][j] = 0;
		}
	}
	for( i = 0; i < numOfCluster; i++) {
		for( k = 0; k < data.clusters[i].documents.length; k++) {
			var docNo = data.clusters[i].documents[k];
			for( l = i + 1; l < numOfCluster; l++) {
				var relScore = overlap[i][l];
				for( z = 0; z < data.clusters[l].documents.length; z++) {
					if(docNo == data.clusters[l].documents[z]) {
						relScore++;
					}
				}
				if(relScore > 0 && overlap[i][l] == 0){
					totalOverlapLink++;
				}
				overlap[i][l] = relScore;
			}
		}
	}
	
	//console.log(totalOverlapLink);
	
	var links = new Array(totalOverlapLink);
	var temp = {
		"source" : "",
		"target" : "",
		"overlapNum" : ""
	};
	
	for( counter = 0,i = 0; i < numOfCluster; i++){ 
		for( l = i; l < numOfCluster; l++) {
			if(overlap[i][l] > 0){
				temp.source = i;
				temp.target = l;
				temp.overlapNum = overlap[i][l];
				if(maxOverlap<overlap[i][l])
					maxOverlap = overlap[i][l];
				//console.log(temp);
				links[counter] = clone(temp);
				counter++
			}
		}
	}

	return links;
}

function getDomainUrlOfAddress(url){
	return (url.match(/:\/\/(.[^/]+)/)[1]).replace('www.','');
}
