extends GutTest

func test_size_gene_output():
    var size_gene = SizeGene.new()
    size_gene.set_value(SizeGene.Allele.SMALL, SizeGene.Allele.SMALL)
    assert_eq(size_gene.get_size(), SizeGene.Size.SMALL, "Size should be SMALL")
    size_gene.set_value(SizeGene.Allele.LARGE, SizeGene.Allele.LARGE)
    assert_eq(size_gene.get_size(), SizeGene.Size.LARGE, "Size should be LARGE")
    size_gene.set_value(SizeGene.Allele.SMALL, SizeGene.Allele.LARGE)
    assert_eq(size_gene.get_size(), SizeGene.Size.MEDIUM, "Size should be MEDIUM")
