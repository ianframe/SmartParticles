class Population
{
  Blob[] population;
  int POPULATION_SIZE;
  ArrayList<Blob> mating_pool;
  float MUTATION_RATE;
  int generations;

  Population(int pop_size, float mute_rate)
  {
    this.POPULATION_SIZE = pop_size;
    this.MUTATION_RATE = mute_rate;
    population = new Blob[POPULATION_SIZE];
    for (int i = 0; i < population.length; i++)
      population[i] = new Blob();
    mating_pool = new ArrayList<Blob>();
    this.generations = 0;
  }

  void step_every_member()
  {
    for (Blob bob : population)
      bob.step();
  }

  void calc_pop_fitness()
  {
    for (Blob bob : population)
      bob.fitness();
  }

  void select()
  {
    mating_pool.clear();

    // Find fittest score of this population
    float max_fitness = population[0].fitness;
    for (int i = 1; i < population.length; i++) {
      if (population[i].fitness > max_fitness)
        max_fitness = population[i].fitness;
    }

    // Fill the mating pool with candidates according to their fitness score
    for (int i = 0; i < population.length; i++) {
      float current_fitness = map(population[i].fitness, 0, max_fitness, 0, 1);
      int num_of_entries = int(current_fitness * 100);
      for (int j = 0; j < num_of_entries; j++)
        mating_pool.add(population[i]);
    }
  }

  void reproduce()
  {
    for (int i = 0; i < population.length; i++) {
      // select two parents
      DNA parentA = mating_pool.get(int(random(mating_pool.size()))).dna;
      DNA parentB = mating_pool.get(int(random(mating_pool.size()))).dna;

      // crossover their dna and mutate
      DNA child_DNA = parentA.crossover(parentB);
      child_DNA.mutate(MUTATION_RATE);

      Blob new_child = new Blob(child_DNA);
      population[i] = new_child;
    }
    // update the population with the new child
    generations++;
  }
}