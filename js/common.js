document.addEventListener( "DOMContentLoaded", function() {
	var refs = document.getElementsByTagName("*")
	for (var i = 0; i < refs.length; ++i)
	{
		var node = refs[i];
		if (node.href && ("" + node.href).startsWith("file://") && ("" + node.href).endsWith("/")) {
			node.href += "index.html";
			console.log(node.href);
		}
	}
}, false );
