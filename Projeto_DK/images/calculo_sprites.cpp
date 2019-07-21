#include <iostream>
#include <dirent.h>
#include <string>
#include <cstring>
#include <cstdlib>
#include <fstream>

#define null 0

using namespace std;

void ajustar_diretorio(char *pasta){
    for(int i = 0 ; pasta[i]!='\0' ; i++){
        if(pasta[i] == '\\'){
            pasta[i] = '/';
        }
    }
}

bool arquivo_s(char *arquivo){
    for(int i = 0 ; arquivo[i] != '\0'; i++){
        if(arquivo[i] == '.' && arquivo[i+1] == 's'){
            return true;
        }
    }

    return false;
}

void encontrar_dimensoes(string frase, int *largura, int *altura){
    string aux;
    aux = frase.substr(frase.find(".word ")+6, frase.find(','));
    
    *largura = atoi(aux.substr(0, aux.find(',')).c_str());
    *altura = atoi(aux.substr(aux.find(',')+1, aux.size()-1).c_str());
}

int tamanho_imagem(char *arquivo){
    string linha;
    int largura = 0, altura = 0;
    ifstream myfile (arquivo);
    if(myfile.is_open()){
        getline(myfile, linha);
        encontrar_dimensoes(linha, &largura, &altura);
        myfile.close();
    }
    return largura*altura;
}

int main( void ){
    DIR *diretorio;
    struct dirent *arquivo;
    
    char pasta[256];
    int tamanhoTotal = 0, tamanhoArquivo = 0;
    cout << "Digite um diretorio contendo os arquivos .s\n";
  
    scanf("%[^\n]", pasta);
    
    ajustar_diretorio(pasta);

    diretorio = opendir( pasta );   //abre diretório
    
    /** Exibe nome dos arquivos do diretório **/
    do{
        arquivo = readdir( diretorio );
        if( arquivo != null ){
            if(arquivo_s(arquivo->d_name)){
                tamanhoArquivo = tamanho_imagem(arquivo->d_name);
                printf( "%s: %d bytes\n", arquivo->d_name, tamanhoArquivo);
                tamanhoTotal += tamanhoArquivo;
            }

        }
    }while( arquivo != null );
    /******************************************/
    
    closedir( diretorio );  //fecha diretório
    
    cout << "\n===========================================\n";
    cout << "Tamanho total dos Sprites: " << tamanhoTotal << " Bytes\n";
    cout << "Memoria de Uso: " << tamanhoTotal / 1024 << " KiB\n";
    cout << "===========================================\n\n";
    system( "PAUSE" );
    return 0;
}