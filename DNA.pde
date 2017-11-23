class DNA
{
  // acceleration vectors
  PVector[] genes;
  float forceFactor = 0.1;

  DNA()
  {
    genes = new PVector[LIFETIME];
    for (int i = 0; i < genes.length; i++) {
      PVector force = PVector.random2D();
      force.mult(forceFactor);
      genes[i] = force;
    }
  }

  DNA(PVector[] child_genes)
  {
    genes = child_genes;
  }

  DNA crossover(DNA other)
  {
    PVector[] child_genes = new PVector[this.genes.length];
    for (int i = 0; i < this.genes.length; i++) {
      float p = random(1);
      if (p < 0.5)  child_genes[i] = this.genes[i];
      else          child_genes[i] = other.genes[i];
    }
    DNA child = new DNA(child_genes);
    return child;
  }

  void mutate(float mute_rate)
  {
    for (int i = 0; i < genes.length; i++) {
      if (random(1) < mute_rate)
        genes[i] = (PVector.random2D()).mult(forceFactor);
    }
  }
}