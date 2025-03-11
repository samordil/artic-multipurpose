# artic-multipurpose

**artic-multipurpose** is a custom fork of **hbv-fieldbioinfomatics**, designed to enhance the **ARTIC pipeline**.
This pipeline **supports circular and linear genomes** while allowing **multi-reference files** for genome assembly.

---

## 🔧 **Features & Fixes**
- **Resolved issues with Linear Genome Processing** (previously buggy in `hbv-fieldbioinformatics`).
- **Guppyplex was missing from artic's subcommands** (fixed and now integrated).
- **Enabled Containerization** with **Docker & Singularity**.

---

## 🛠 **Installation**
artic-multipurpose can be installed **manually**, using **Conda**, or via **Docker/Singularity**.

### 1. **Manual Installation (Source)**
```sh
git clone https://github.com/samordil/artic-multipurpose.git
cd artic-multipurpose
```

### 2. **Installing Dependencies with Conda**
```sh
conda env create -f environment.yml
conda activate artic-multipurpose
```

### 3. **Installing the Pipeline**
```sh
python setup.py install
```

### 4. **Testing the Installation**
```sh
artic -v
```

### 4. **Testing the Installation**
```sh
artic minion --circular --medaka --normalise 400 --threads 8 --scheme-directory ~/hbv-fieldbioinfomatics/primerschemes --read-file {}  --medaka-model r1041_e82_400bps_hac_v4.3.0 hbv-600/V2.1.0L output/barcode13
```

## 🛠 **using Docker or singularity containers**
### 1. **Using docker**
```sh
docker pull samordil/artic-multipurpose:1.5.1
docker run --rm samordil/artic-multipurpose:1.5.1 artic -h
```

### 2. **Using singularity**
```sh
singularity pull artic-multipurpose_1.5.1.sif docker://samordil/artic-multipurpose:1.5.1
singularity exec artic-multipurpose_1.5.1.sif artic -h
```