// SPDX-License-Identifier: MIT

pragma solidity >0.8.0;

 

contract Subasta{

    uint256 public valorInicial;

    uint256 public fechaInicio;

    uint256 public tiempoDuracion;

    uint256 public mayorOferta;

    address public ofertanteGanador;

    uint8 public semaforo;

    address private owner;

    //mapping para hacer un punteo de direcciones y respectivos valores

    mapping (address => uint256 ) public valoreMetido;

 

    //funcion constructor

    constructor() {

        owner = msg.sender;

        valorInicial= 1 gwei;

        fechaInicio = block.timestamp; // para poner la fecha de que se hizo el contrato

        tiempoDuracion = fechaInicio + 7 days;

    }

 

    //funcion tipo get

    function getOferenteGanador() external view returns (address){

        return ofertanteGanador;

    }

 

    //funcion tipo get

    function getMayorOferta() external view returns (uint256){

        return mayorOferta;

    }

 

    //funcion tipo set

    function setOferta() external payable {

        //requiere si o si para funcionar

        require(semaforo == 0, "la subasta finalizo");

        //msg.value va cuando va dinero y _cuando es variable local

        uint256 _valorOferado = msg.value;

        require(_valorOferado > valorInicial, "valor menor al inicial");

 

        if (_valorOferado > mayorOferta){

            address _adressOferente = msg.sender;

            mayorOferta = _valorOferado ;

            ofertanteGanador = _adressOferente;

            valoreMetido[_adressOferente] += _valorOferado;

        } else{

            revert("no superaste");//es como que la transaccion no paso

        }

    }

 

    function FinzalizarSubastas() external  {

        require(owner==msg.sender,"usted no tiene permisos");

        semaforo = 1 ;

        //se necesita tener un owner de contrato para que sea exclusivo

    }

 

}